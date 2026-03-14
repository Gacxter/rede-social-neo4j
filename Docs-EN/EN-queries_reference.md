# 📊 Query Reference — Neo4j Social Network

> Complete documentation of the project's Cypher queries, including business description, fully commented code, expected output and a changelog of all fixes applied during development.

---

## 📋 Table of Contents

- [Main Queries (Q1–Q11)](#main-queries)
- [Linked List Queries (QL1–QL6)](#linked-list-queries)
- [Fix Changelog](#fix-changelog)

---

## Main Queries

---

### Q1 — Marketing Reach with APOC

**Business question:**
> For a marketing campaign targeting 25 to 35-year-olds connected to Roberto, what is the minimum number of hops needed to reach each target?

**Note:** Requires the APOC library. For Neo4j Aura Free, use **Q2** instead.

```cypher
// Q1: Shortest path to 25–35-year-olds connected to Roberto (with APOC)
// Converts dataNascimento (dd/MM/yyyy) to date() using apoc.date
MATCH (roberto:Usuario {email:'roberto@email.com'})
MATCH (alvo:Usuario)
WHERE alvo <> roberto
  AND date(apoc.date.format(apoc.date.parse(alvo.dataNascimento, 'ms', 'dd/MM/yyyy'), 'ms', 'yyyy-MM-dd'))
      >= date('1991-03-14')
  AND date(apoc.date.format(apoc.date.parse(alvo.dataNascimento, 'ms', 'dd/MM/yyyy'), 'ms', 'yyyy-MM-dd'))
      <= date('2001-03-14')
MATCH path = shortestPath((roberto)-[*1..6]-(alvo))
RETURN alvo.nome            AS Name,
       alvo.dataNascimento  AS BirthDate,
       length(path)         AS MinHops,
       [n IN nodes(path) WHERE n:Usuario | n.nome] AS PathUsers
ORDER BY MinHops ASC;
```

**Expected output:**

| Name | BirthDate | MinHops | PathUsers |
|---|---|---|---|
| João Marins | 29/11/1990 | 1 | [Roberto Alves, João Marins] |
| Ana Schultz | 17/03/1995 | 1 | [Roberto Alves, Ana Schultz] |
| Guilherme Costa | 14/07/1993 | 2 | [Roberto Alves, João Marins, Guilherme Costa] |
| ... | ... | ... | ... |

---

### Q2 — Marketing Reach without APOC ✅ (Recommended)

**Business question:**
> Same as Q1, but using only native Cypher functions — fully compatible with Neo4j Aura Free Tier.

> ⚠️ **This is the corrected version.** See the fix changelog at the end of this document.

```cypher
// Q2: Shortest path to 25–35-year-olds connected to Roberto (no APOC)
// Uses native split() to convert dd/MM/yyyy → date(yyyy-MM-dd)
MATCH (roberto:Usuario {email:'roberto@email.com'})
MATCH (alvo:Usuario)
WHERE alvo <> roberto

// Step 1: split the date string into parts [dd, MM, yyyy]
WITH roberto, alvo,
     split(alvo.dataNascimento, '/') AS partes

// Step 2: rebuild in the format accepted by date() → yyyy-MM-dd
WITH roberto, alvo, partes,
     date(partes[2] + '-' + partes[1] + '-' + partes[0]) AS dtNasc

// Step 3: calculate age with duration.between()
WITH roberto, alvo, dtNasc,
     duration.between(dtNasc, date('2026-03-14')).years AS idade

// Step 4: filter age range 25–35
WHERE idade >= 25 AND idade <= 35

// Step 5: find the shortest path (max. 6 hops)
MATCH path = shortestPath((roberto)-[*1..6]-(alvo))

RETURN alvo.nome           AS Name,
       alvo.dataNascimento AS BirthDate,
       idade               AS Age,
       length(path)        AS MinHops,
       [n IN nodes(path) WHERE n:Usuario | n.nome] AS PathUsers
ORDER BY MinHops ASC;
```

**Expected output:**

| Name | Age | MinHops | PathUsers |
|---|---|---|---|
| Ana Schultz | 31 | 1 | [Roberto Alves, Ana Schultz] |
| João Marins | 35 | 1 | [Roberto Alves, João Marins] |
| Thiago Ferreira | 37 | 1 | [Roberto Alves, Thiago Ferreira] |
| Guilherme Costa | 32 | 2 | [Roberto Alves, João Marins, Guilherme Costa] |
| Mariana Serena | 28 | 2 | [Roberto Alves, Ana Schultz, Mariana Serena] |
| ... | ... | ... | ... |

---

### Q3 — Direct Friends of a User

**Business question:**
> Who are Roberto's direct friends? (1 hop)

```cypher
// Q3: Lists the immediate friends of a user
// E_AMIGO_DE is bidirectional (two directed arcs)
// Using --> captures only outgoing arcs and avoids duplicates
MATCH (roberto:Usuario {email:'roberto@email.com'})-[:E_AMIGO_DE]->(amigo:Usuario)
RETURN amigo.nome            AS Friend,
       amigo.dataNascimento  AS BirthDate
ORDER BY amigo.nome;
```

**Expected output:**

| Friend | BirthDate |
|---|---|
| Ana Schultz | 17/03/1995 |
| João Marins | 29/11/1990 |
| Renato Gomes | 28/03/1987 |
| Thiago Ferreira | 25/02/1989 |

---

### Q4 — User Actions on Posts

**Business question:**
> Which posts has Roberto liked, commented on or shared, and when?

```cypher
// Q4: Retrieves all interactions of a user with posts
// Traverses the intermediate Acao node to reach the Post
MATCH (roberto:Usuario {email:'roberto@email.com'})
      -[r:CURTIU_O_POST|COMENTOU_O_POST|COMPARTILHOU_O_POST]->
      (a:Acao)-[:PERTENCE_AO_POST]->(p:Post)
RETURN type(r)    AS ActionType,
       p.titulo   AS Post,
       a.dataHora AS DateTime
ORDER BY a.dataHora;
```

**Expected output:**

| ActionType | Post | DateTime |
|---|---|---|
| CURTIU_O_POST | Networking que funciona de verdade | 06/03/2024 11h00'00'' |

---

### Q5 — Most Active Communities by Post Count

**Business question:**
> Which communities concentrate the most published content?

```cypher
// Q5: Counts posts linked to each community
// Posts relate to communities via PERTENCE_A
MATCH (p:Post)-[:PERTENCE_A]->(c:Comunidade)
RETURN c.nome      AS Community,
       count(p)    AS TotalPosts
ORDER BY TotalPosts DESC;
```

**Expected output:**

| Community | TotalPosts |
|---|---|
| Dev & Café | 5 |
| Investidores Jovens | 5 |
| Foodies SP | 4 |
| Galera do Rock | 4 |
| Pedalando pela Vida | 3 |

---

### Q6 — Users Belonging to More Than One Community

**Business question:**
> Which users are members of multiple communities? (most socially active profiles)

```cypher
// Q6: Identifies multi-community users
// Groups by user and filters those with more than 1 community
MATCH (u:Usuario)-[:PERTENCE_A]->(c:Comunidade)
WITH u, count(c) AS totalCommunities
WHERE totalCommunities > 1
RETURN u.nome           AS User,
       totalCommunities  AS TotalCommunities
ORDER BY totalCommunities DESC;
```

**Expected output:**

| User | TotalCommunities |
|---|---|
| Ana Schultz | 2 |
| Beatriz Nunes | 2 |
| Lucas Mendes | 2 |
| Guilherme Costa | 2 |
| Mariana Serena | 2 |
| Renato Gomes | 2 |

---

### Q7 — Most Engaged Posts

**Business question:**
> Which posts have accumulated the most interactions (likes + comments + shares)?

```cypher
// Q7: Engagement ranking by post
// Counts all Acao nodes linked to each post, regardless of type
MATCH (a:Acao)-[:PERTENCE_AO_POST]->(p:Post)
RETURN p.titulo         AS Post,
       p.autor          AS Author,
       count(a)         AS TotalInteractions
ORDER BY TotalInteractions DESC
LIMIT 10;
```

**Expected output:**

| Post | Author | TotalInteractions |
|---|---|---|
| Como diversificar sua carteira em 2024 | Roberto Alves | 4 |
| Top 10 álbuns de Rock dos anos 90 | Ana Schultz | 3 |
| Pedalada até Embu das Artes | Carlos Eduardo | 3 |
| Docker do zero: guia prático | Guilherme Costa | 3 |
| ... | ... | ... |

---

### Q8 — Connection Degree per User

**Business question:**
> Which users have the most friendships? (potential network influencers)

```cypher
// Q8: Calculates the out-degree of each Usuario node
// Counts outgoing E_AMIGO_DE relationships to avoid double counting
MATCH (u:Usuario)-[:E_AMIGO_DE]->(outro:Usuario)
RETURN u.nome        AS User,
       count(outro)  AS NumberOfFriends
ORDER BY NumberOfFriends DESC;
```

**Expected output:**

| User | NumberOfFriends |
|---|---|
| Roberto Alves | 4 |
| Guilherme Costa | 4 |
| Ana Schultz | 3 |
| Renato Gomes | 3 |
| João Marins | 3 |
| ... | ... |

---

### Q9 — Users with No Community

**Business question:**
> Which users don't belong to any community? (potential targets for engagement campaigns)

```cypher
// Q9: Filters users with no PERTENCE_A relationship to a Community
// NOT (...) checks for the absence of a pattern in the graph
MATCH (u:Usuario)
WHERE NOT (u)-[:PERTENCE_A]->(:Comunidade)
RETURN u.nome AS UserWithNoCommunity;
```

**Expected output:**

| UserWithNoCommunity |
|---|
| Patrícia Lima |
| Fernanda Rocha |
| Camila Borges |
| Rafael Souza |
| Juliana Pinto |
| Isabela Vieira |
| Diego Carvalho |
| Larissa Matos |
| Vinícius Andrade |
| Helena Faria |

---

### Q10 — Social Bridges (Simplified Betweenness)

**Business question:**
> Which users act as bridges between distinct groups? Who connects parts of the network that would otherwise be disconnected?

```cypher
// Q10: Identifies intermediate nodes in short paths
// Counts how many distinct destinations each intermediate node
// helps reach from Roberto — approximation of betweenness centrality
MATCH (roberto:Usuario {email:'roberto@email.com'}), (alvo:Usuario)
WHERE alvo <> roberto
MATCH path = shortestPath((roberto)-[*1..5]-(alvo))
WHERE length(path) > 2

// Extract intermediate nodes (exclude start and end of path)
UNWIND nodes(path)[1..-1] AS intermediario
WITH intermediario, count(DISTINCT alvo) AS pathsCovered
WHERE intermediario:Usuario
RETURN intermediario.nome  AS SocialBridge,
       pathsCovered         AS DestinationsReached
ORDER BY pathsCovered DESC
LIMIT 5;
```

**Expected output:**

| SocialBridge | DestinationsReached |
|---|---|
| João Marins | 8 |
| Ana Schultz | 7 |
| Renato Gomes | 6 |
| Thiago Ferreira | 4 |
| Guilherme Costa | 4 |

---

### Q11 — Friend Suggestions ⭐

**Business question:**
> Who does a user probably know but isn't friends with yet? ("People you may know")

```cypher
// Q11: Friend suggestion based on friends of friends
//
// Logic:
//   Me → Direct Friend → Candidate (friend of my friend)
//
// Criteria:
//   - Candidate cannot be the user themselves
//   - Candidate cannot already be a direct friend
//   - The more mutual friends, the more relevant the suggestion
MATCH (eu:Usuario {email:'roberto@email.com'})

// Step 1: find all direct friends
MATCH (eu)-[:E_AMIGO_DE]->(amigoDireto:Usuario)

// Step 2: from each direct friend, reach their friends
MATCH (amigoDireto)-[:E_AMIGO_DE]->(candidato:Usuario)

// Step 3: exclude the user themselves and existing friends
WHERE candidato <> eu
  AND NOT (eu)-[:E_AMIGO_DE]->(candidato)

// Step 4: aggregate — collect mutual friends and count
WITH eu, candidato,
     collect(DISTINCT amigoDireto.nome) AS mutualFriends,
     count(DISTINCT amigoDireto)        AS totalMutual

ORDER BY totalMutual DESC

RETURN candidato.nome   AS FriendSuggestion,
       totalMutual       AS MutualFriendCount,
       mutualFriends     AS WhoAreMutualFriends
LIMIT 10;
```

**Expected output:**

| FriendSuggestion | MutualFriendCount | WhoAreMutualFriends |
|---|---|---|
| Guilherme Costa | 2 | [João Marins, Thiago Ferreira] |
| Juliana Pinto | 2 | [Renato Gomes, João Marins] |
| Diego Carvalho | 1 | [Renato Gomes] |
| Camila Borges | 1 | [Ana Schultz] |
| Mariana Serena | 1 | [Ana Schultz] |

---

## Linked List Queries

---

### QL1 — Full User Feed

**Business question:**
> What are a user's posts in chronological order?

```cypher
// QL1: Traverses a user's post linked list
// PRIMEIRO_POST points to the start of the chain
// PROXIMO_POST* traverses all edges to the end
MATCH (u:Usuario {email:'ana@email.com'})-[:PRIMEIRO_POST]->(inicio:Post)
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(post:Post)
RETURN post.titulo  AS Title,
       post.autor   AS Author
ORDER BY length(path) ASC;
```

**Expected output:**

| Title | Author |
|---|---|
| Top 10 álbuns de Rock dos anos 90 | Ana Schultz |
| Show do Foo Fighters foi incrível! | Ana Schultz |
| Bandas independentes que você precisa conhecer | Ana Schultz |
| Tocando violão depois de 2 anos | Ana Schultz |

---

### QL2 — Access the Nth Post in the Feed

**Business question:**
> What is the second post published by a user?

```cypher
// QL2: Directly accesses the Nth element of the linked list
// *1 = exactly 1 hop from the start = 2nd post
// Change the number to access any position
MATCH (u:Usuario {email:'mariana@email.com'})-[:PRIMEIRO_POST]->(inicio:Post)
MATCH (inicio)-[:PROXIMO_POST*1]->(secondPost:Post)
RETURN secondPost.titulo AS SecondPost;
```

**Expected output:**

| SecondPost |
|---|
| Receita: Risoto de cogumelos selvagens |

---

### QL3 — Insert New Post at the End of the Feed

**Business question:**
> How do you add a new post to the end of a user's linked list while maintaining chain integrity?

```cypher
// QL3: Linked list maintenance — insert at the end
//
// Steps:
//   1. Find the current PostFinal (last in the chain)
//   2. Remove the :PostFinal label from the current last node
//   3. Connect the current last to the new post
//   4. Mark the new post as :PostFinal
MATCH (u:Usuario {email:'ana@email.com'})-[:PRIMEIRO_POST]->(inicio:Post)
MATCH (inicio)-[:PROXIMO_POST*0..]->(ultimo:Post:PostFinal)
MATCH (novoPost:Post {titulo:'Tocando violão depois de 2 anos'})
REMOVE ultimo:PostFinal
CREATE (ultimo)-[:PROXIMO_POST {ordem: 99}]->(novoPost)
SET novoPost:PostFinal
RETURN novoPost.titulo AS NewLastPost;
```

---

### QL4 — User Friendship History ✅ (Fixed)

**Business question:**
> In what chronological order did Roberto make friends on the network?

> ⚠️ **This is the corrected version.** See the fix changelog at the end of this document.

```cypher
// QL4: Traverses a user's friendship linked list
//
// The {de} property on PROXIMA_AMIZADE identifies which user's chain
// it belongs to, preventing contamination between different users'
// lists that share the same nodes.
//
// FIX APPLIED: property filter moved to WHERE with ALL()
// because combining {property} and *quantifier in the same [] is invalid
MATCH (u:Usuario {email:'roberto@email.com'})-[:PRIMEIRA_AMIZADE]->(primeiro:Usuario)
MATCH path = (primeiro)-[:PROXIMA_AMIZADE*0..]->(amigo:Usuario)
WHERE ALL(r IN relationships(path) WHERE r.de = 'roberto@email.com')
RETURN amigo.nome            AS Friend,
       amigo.dataNascimento  AS BirthDate,
       length(path) + 1      AS ChronologicalOrder
ORDER BY ChronologicalOrder ASC;
```

**Expected output:**

| Friend | BirthDate | ChronologicalOrder |
|---|---|---|
| Ana Schultz | 17/03/1995 | 1 |
| João Marins | 29/11/1990 | 2 |
| Thiago Ferreira | 25/02/1989 | 3 |
| Renato Gomes | 28/03/1987 | 4 |

---

### QL5 — Most Recent Friend of Each User ✅ (Fixed)

**Business question:**
> Who was the most recent friendship added by each user?

> ⚠️ **This is the corrected version.** See the fix changelog at the end of this document.

```cypher
// QL5: Finds the last node of each friendship linked list
//
// Strategy: traverse the list and identify the node that has
// NO next element — that is the last in the chain.
//
// FIX APPLIED: same fix as QL4 — filter moved to WHERE with ALL()
MATCH (u:Usuario)-[:PRIMEIRA_AMIZADE]->(primeiro:Usuario)
MATCH path = (primeiro)-[:PROXIMA_AMIZADE*0..]->(ultimo:Usuario)
WHERE ALL(r IN relationships(path) WHERE r.de = u.email)
  AND NOT (ultimo)-[:PROXIMA_AMIZADE {de: u.email}]->()
RETURN u.nome       AS User,
       ultimo.nome  AS MostRecentFriend;
```

**Expected output:**

| User | MostRecentFriend |
|---|---|
| Roberto Alves | Renato Gomes |
| Guilherme Costa | Vinícius Andrade |
| Ana Schultz | Mariana Serena |
| João Marins | Beatriz Nunes |
| ... | ... |

---

### QL6 — Feed Size per User ✅ (Fixed)

**Business question:**
> How many posts has each user published? (based on linked list)

> ⚠️ **This is the corrected version.** See the fix changelog at the end of this document.

```cypher
// QL6: Counts the total posts in each user's feed
//
// FIX APPLIED: MIN(length(path)) used to avoid multiple rows per user.
// The *0.. pattern was generating one path per length (0,1,2...N),
// resulting in duplicate rows for the same user.
// MIN() collapses all paths into the shortest one (= direct path to PostFinal).
MATCH (u:Usuario)-[:PRIMEIRO_POST]->(inicio:Post)
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(fim:Post)
WHERE fim:PostFinal
WITH u, MIN(length(path)) + 1 AS TotalPosts
RETURN u.nome    AS User,
       TotalPosts
ORDER BY TotalPosts DESC;
```

**Expected output:**

| User | TotalPosts |
|---|---|
| Ana Schultz | 4 |
| Mariana Serena | 4 |
| Roberto Alves | 3 |
| Guilherme Costa | 3 |
| Carlos Eduardo | 3 |
| Fernanda Rocha | 3 |
| Beatriz Nunes | 3 |
| Camila Borges | 3 |
| Renato Gomes | 3 |
| Diego Carvalho | 3 |
| Thiago Ferreira | 2 |
| Patrícia Lima | 2 |
| Lucas Mendes | 2 |
| João Marins | 2 |
| Juliana Pinto | 2 |
| Isabela Vieira | 2 |
| Larissa Matos | 2 |
| Vinícius Andrade | 2 |
| Rafael Souza | 1 |
| Helena Faria | 1 |

---

## Fix Changelog

A record of real difficulties encountered during development and how they were resolved.

---

### Fix 1 — Q2: Invalid string method chaining

**Error:**
```
Invalid input '(', expected: an expression, ')' or ','
(line 6, column 57)
"date(replace(alvo.dataNascimento, '/', '-').split('-')[2] + '-' +"
```

**Cause:** Cypher does not support method chaining in the style of `.split()` — that is Python/JavaScript syntax.

**Before (❌):**
```cypher
date(replace(alvo.dataNascimento, '/', '-').split('-')[2] + '-' +
     replace(alvo.dataNascimento, '/', '-').split('-')[1] + '-' +
     replace(alvo.dataNascimento, '/', '-').split('-')[0])
```

**After (✅):**
```cypher
WITH split(alvo.dataNascimento, '/') AS partes
WITH date(partes[2] + '-' + partes[1] + '-' + partes[0]) AS dtNasc
```

**Rule learned:** In Cypher, string functions are standalone. Intermediate results must be captured via `WITH`.

---

### Fix 2 — QL4 and QL5: Property filter with quantifier

**Error:**
```
Invalid input '*', expected: 'WHERE' or ']'
(line 2, column 68)
"MATCH path = (primeiro)-[:PROXIMA_AMIZADE* {de:'roberto@email.com'}*0..]->(amigo:Usuario)"
```

**Cause:** In Cypher, you cannot combine a property filter `{key: value}` and a quantifier `*N..` inside the same relationship `[...]`.

**Before (❌):**
```cypher
MATCH path = (a)-[:PROXIMA_AMIZADE* {de: u.email}*0..]->(b)
```

**After (✅):**
```cypher
MATCH path = (a)-[:PROXIMA_AMIZADE*0..]->(b)
WHERE ALL(r IN relationships(path) WHERE r.de = u.email)
```

**Rule learned:** Property filters on relationships with quantifiers always go into `WHERE` using the `ALL()` predicate.

---

### Fix 3 — QL6: Duplicate results with `*0..`

**Symptom:** Ana Schultz appeared 6 times in a row with decreasing counts (6, 6, 6, 5, 5, 5...).

**Cause:** The `*0..` pattern generates one result per possible path length (0, 1, 2... up to N), not just for the longest path. For a list with 4 posts, this produced 4 rows for the same user.

**Before (❌):**
```cypher
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(fim:Post:PostFinal)
RETURN u.nome, length(path) + 1 AS TotalPosts
```

**After (✅):**
```cypher
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(fim:Post)
WHERE fim:PostFinal
WITH u, MIN(length(path)) + 1 AS TotalPosts
RETURN u.nome, TotalPosts
```

**Rule learned:** When using `*0..` to traverse linked lists and needing the total length, always use `MIN()` or `MAX()` in the `WITH` clause to collapse multiple paths into a single result per node.
