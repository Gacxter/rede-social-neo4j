# 🕸️ Neo4j Social Network — Graph-Based Social Network Simulation

> Project developed as part of the [DIO](https://www.dio.me/) practical challenge on the **Graph Databases with Neo4j** track.  
> Simulates a complete social network with users, posts, interactions, communities, linked lists and intelligent business queries.

---

## 📋 Table of Contents

- [Context and Motivation](#-context-and-motivation)
- [Why Graphs?](#-why-graphs)
- [Graph Model](#-graph-model)
- [Repository Structure](#-repository-structure)
- [Prerequisites](#-prerequisites)
- [How to Run](#-how-to-run)
- [Dataset](#-dataset)
- [Business Queries](#-business-queries)
- [Linked Lists and Indexes](#-linked-lists-and-indexes)
- [Troubleshooting](#-troubleshooting)
- [Technologies](#-technologies)
- [Author](#-author)

---

## 🎯 Context and Motivation

Social networks are, by nature, **graphs**: people are nodes, relationships are edges. Modeling this domain in a relational database would require multiple join tables and deep `JOIN` queries to answer simple questions like *"which of Roberto's friends are between 25 and 35 years old?"*.

This project builds a simulated social network with:

- **20 users** with realistic profiles
- **50 posts** distributed among users
- **5 thematic communities**
- **Interactions** (likes, comments, shares) as intermediate nodes
- **Linked lists** for chronological feed and friendship history
- **11 business queries** with comments, including reach analysis for marketing campaigns

---

## 🔍 Why Graphs?

| Scenario | Relational Database | Neo4j (Graph) |
|---|---|---|
| Friends of friends | 2+ nested JOINs | 1 pattern `(a)-[:IS_FRIEND_OF*2]->(b)` |
| Shortest path between users | External algorithm | Native `shortestPath()` |
| Friend suggestions | Complex recursive CTE | Simple 2-hop query |
| Communities and membership | Association table | Direct `BELONGS_TO` relationship |
| Chronological feed | `ORDER BY` on table | Linked list with `NEXT_POST` |

In graphs, **the data structure is the model** — there is no impedance mismatch between the domain and storage.

---

## 🗺️ Graph Model

### Visualizing the schema in Neo4j

After importing the data, run this in the **Neo4j Browser** or **Aura Console**:

```cypher
CALL db.schema.visualization()
```

This generates an interactive visual diagram with all labels and relationship types in your graph.

### Labels (Nodes)

| Label | Description | Key Properties |
|---|---|---|
| `Usuario` | User profile | `id`, `nome`, `email`, `dataNascimento`, `dataCadastro` |
| `Post` | Content publication | `titulo`, `conteudo`, `autor` |
| `Acao` | Intermediate interaction node | `tipo`, `dataHora` |
| `Curtida` | Sublabel of Acao (Like) | — |
| `Comentario` | Sublabel of Acao (Comment) | `texto` |
| `Compartilhamento` | Sublabel of Acao (Share) | — |
| `Comunidade` | Thematic group | `nome`, `tema`, `responsavel` |

### Relationship Types

| Relationship | From → To | Properties |
|---|---|---|
| `E_AMIGO_DE` | Usuario → Usuario | `dataInicio` |
| `POSTOU` | Usuario → Post | `dataPostagem` |
| `CURTIU_O_POST` | Usuario → Acao | — |
| `COMENTOU_O_POST` | Usuario → Acao | — |
| `COMPARTILHOU_O_POST` | Usuario → Acao | — |
| `PERTENCE_AO_POST` | Acao → Post | — |
| `PERTENCE_A` | Usuario/Post → Comunidade | — |
| `PRIMEIRO_POST` | Usuario → Post | — |
| `PROXIMO_POST` | Post → Post | `ordem` |
| `PRIMEIRA_AMIZADE` | Usuario → Usuario | — |
| `PROXIMA_AMIZADE` | Usuario → Usuario | `de`, `dataInicio` |

### Simplified Diagram

```
(Usuario)-[:E_AMIGO_DE]->(Usuario)
(Usuario)-[:POSTOU {dataPostagem}]->(Post)
(Usuario)-[:CURTIU_O_POST]->(Acao:Curtida)-[:PERTENCE_AO_POST]->(Post)
(Usuario)-[:COMENTOU_O_POST]->(Acao:Comentario)-[:PERTENCE_AO_POST]->(Post)
(Usuario)-[:COMPARTILHOU_O_POST]->(Acao:Compartilhamento)-[:PERTENCE_AO_POST]->(Post)
(Usuario)-[:PERTENCE_A]->(Comunidade)
(Post)-[:PERTENCE_A]->(Comunidade)
(Usuario)-[:PRIMEIRO_POST]->(Post)-[:PROXIMO_POST*]->(Post)
(Usuario)-[:PRIMEIRA_AMIZADE]->(Usuario)-[:PROXIMA_AMIZADE*]->(Usuario)
```

> 💡 **Tip:** Use [Arrows.app](https://arrows.app/) to draw and export a visual diagram of the model before presenting your project.

---

## 📁 Repository Structure

```
neo4j-social-network/
│
├── cypher/
│   ├── 01_rede_social_neo4j.cypher          # Main structure: constraints, nodes and relationships
│   └── 02_listas_e_indices.cypher           # Linked lists, indexes and list queries
│
├── queries/
│   └── queries_negocio.md                   # 11 queries + 6 list queries with description,
│                                            # commented code, expected output and fix history
│
├── docs-en/
│   ├── README.md                            # This file (English version)
│   └── queries_reference.md                 # Full query reference in English
│
├── screenshots/
│   ├── Queries_Screenshots/                 # Screenshots of Q1–Q11 in Neo4j Browser
│   ├── Queries_Lists_ScreenShots/           # Screenshots of QL1–QL6 (linked lists)
│   └── .gitkeep
│
├── .gitignore                               # Ignores credentials, local data and OS files
├── README.md                                # Main README (Portuguese)
└── LICENSE                                  # MIT License
```

---

## ⚙️ Prerequisites

- **Neo4j Aura** (free) — [console.neo4j.io](https://console.neo4j.io) **or** Neo4j Desktop installed locally
- **Git** installed
- A modern browser (for Neo4j Browser)

> This project does **not use APOC** to maintain full compatibility with the Neo4j Aura Free Tier.

---

## 🚀 How to Run

### 1. Clone the repository

```bash
git clone https://github.com/your-username/neo4j-social-network.git
cd neo4j-social-network
```

### 2. Create an instance on Neo4j Aura

1. Go to [console.neo4j.io](https://console.neo4j.io)
2. Click **New Instance** → choose **AuraDB Free**
3. Save the **URI**, **username** (`neo4j`) and the generated **password**
4. Wait for the status to become **Running** (may take a few minutes)

### 3. Open Neo4j Browser

1. On the instance screen, click **Open** → **Neo4j Browser**
2. Log in with your credentials

### 4. Run the scripts in the correct order

> ⚠️ **Important:** Run each section separately, waiting for a success confirmation before moving to the next one.

**Step 4.1 — Constraints and Base Indexes**

Copy and paste only **Section 0** of `01_rede_social_neo4j.cypher` into the Browser editor and click ▶️ Run.

**Step 4.2 — Node Creation**

Run the sections in this order:
- Section 1: Users
- Section 2: Communities
- Section 3: Posts

**Step 4.3 — Relationships**

Run the sections in this order:
- Section 4: Friendships (`E_AMIGO_DE`)
- Section 5: Posts (`POSTOU`)
- Section 6: Actions (Likes, Comments, Shares)
- Sections 7 & 8: Community Members and Posts

**Step 4.4 — Linked Lists and Additional Indexes**

Run `02_listas_e_indices.cypher` section by section:
- Section 1: Indexes
- Section 2: Post Feed Linked List
- Section 3: Friendship History Linked List

### 5. Verify the import

```cypher
// Node count by label
MATCH (n)
RETURN labels(n) AS Label, count(n) AS Total
ORDER BY Total DESC;
```

Expected result:

| Label | Total |
|---|---|
| Acao | ~38 |
| Post | 50 |
| Usuario | 20 |
| Comunidade | 5 |

```cypher
// Relationship count by type
MATCH ()-[r]->()
RETURN type(r) AS Type, count(r) AS Total
ORDER BY Total DESC;
```

### 6. Visualize the schema

```cypher
CALL db.schema.visualization()
```

---

## 📊 Dataset

The dataset is synthetic and was created to simulate real behaviors of a Brazilian social network. All names, emails and IDs are fictional.

### Users (sample)

| Name | Email | Birth Date | Communities |
|---|---|---|---|
| Roberto Alves | roberto@email.com | 05/08/1988 | Investidores Jovens |
| Ana Schultz | ana@email.com | 17/03/1995 | Galera do Rock, Foodies SP |
| Guilherme Costa | guilherme@email.com | 14/07/1993 | Dev & Café, Investidores Jovens |
| Mariana Serena | mariana@email.com | 02/12/1997 | Galera do Rock, Foodies SP |
| ... | ... | ... | ... |

### Communities

| Name | Theme | Manager |
|---|---|---|
| Galera do Rock | Music | Ana Schultz |
| Dev & Café | Technology | Guilherme Costa |
| Pedalando pela Vida | Cycling | Carlos Eduardo |
| Foodies SP | Gastronomy | Mariana Serena |
| Investidores Jovens | Finance | Roberto Alves |

---

## 🔎 Business Queries

The project answers the following business questions through Cypher:

### Q1–Q2 🎯 Marketing Reach
> *"For a marketing campaign targeting 25 to 35-year-olds connected to Roberto, what is the minimum number of hops needed to reach each target?"*

Uses `shortestPath()` combined with age range calculation via native `split()` and `date()` — no APOC required.

### Q3 — Direct Friends
> *"Who are a user's direct friends?"*

### Q4 — User Actions on Posts
> *"Which posts has a user liked, commented on or shared?"*

### Q5 — Most Active Communities
> *"Which communities concentrate the most content?"*

### Q6 — Multi-community Users
> *"Which users belong to more than one community?"*

### Q7 — Most Engaged Posts
> *"Which posts have the most interactions (likes + comments + shares)?"*

### Q8 — Connection Degree
> *"How many friends does each user have?"*

### Q9 — Isolated Users
> *"Which users don't belong to any community?"*

### Q10 — Social Bridges
> *"Which users act as bridges between distinct groups?"*  
> *(Simplified betweenness — counts how many short paths pass through each intermediate node)*

### Q11 — Friend Suggestions ⭐
> *"Who does a user probably know but isn't friends with yet?"*  
> Based on the classic **friends of friends** pattern, with mutual connection count.

---

## 🔗 Linked Lists and Indexes

### Why linked lists in a graph?

In Neo4j, storing order in properties (e.g. `order: 1`) requires sorting in the query. A **native linked list** uses the graph structure itself to represent sequence, making operations like *"next post"* or *"insert at end of feed"* O(1) — no sorting needed.

### Post Feed (Linked List)
```
Usuario -[:PRIMEIRO_POST]→ Post¹ -[:PROXIMO_POST]→ Post² -[:PROXIMO_POST]→ Post³:PostFinal
```
- Labels `:PostInicial` and `:PostFinal` mark the ends of the chain
- Inserting at the end: shift `:PostFinal` and create a new edge

### Friendship History (Linked List)
```
Usuario -[:PRIMEIRA_AMIZADE]→ Friend¹ -[:PROXIMA_AMIZADE {de}]→ Friend² → ...
```
- The `de` property (owner's email) prevents contamination between different users' lists that share the same nodes
- Ordered chronologically from oldest to most recent friendship

### Indexes created

| Index | Field | Justification |
|---|---|---|
| `idx_usuario_nascimento` | `Usuario.dataNascimento` | Age range marketing query |
| `idx_post_autor` | `Post.autor` | Frequent search by creator |
| `idx_acao_tipo` | `Acao.tipo` | Filter by interaction type |
| `idx_comunidade_nome` | `Comunidade.nome` | All community MATCHes |
| `idx_comunidade_tema` | `Comunidade.tema` | Search by topic |
| `idx_postou_data` | `rel POSTOU.dataPostagem` | Chronological ordering |
| `idx_amizade_data` | `rel E_AMIGO_DE.dataInicio` | Friendship history |

---

## 🩹 Troubleshooting

Real difficulties encountered during development and how they were resolved.

---

### ❌ Error: Invalid string method chaining

**Symptom:**
```
Invalid input '(', expected: an expression, ')' or ','
"date(replace(alvo.dataNascimento, '/', '-').split('-')[2] + '-' +"
```

**Cause:** Neo4j Cypher does not support method chaining in the style of `.split()` — that is Python/JavaScript syntax.

**Fix:** Use `split()` as a standalone function and assign the result to a variable via `WITH`:

```cypher
-- ❌ Wrong
date(replace(alvo.dataNascimento, '/', '-').split('-')[2] + ...)

-- ✅ Correct
WITH split(alvo.dataNascimento, '/') AS partes
WITH date(partes[2] + '-' + partes[1] + '-' + partes[0]) AS dtNasc
```

---

### ❌ Error: Property filter and quantifier in the same bracket

**Symptom:**
```
Invalid input '*', expected: 'WHERE' or ']'
"MATCH path = (a)-[:PROXIMA_AMIZADE* {de:'email'}*0..]->(b)"
```

**Cause:** In Cypher, you cannot combine `{property: value}` and `*0..` inside the same relationship `[...]`.

**Fix:** Move the filter to a `WHERE` clause using the `ALL()` predicate:

```cypher
-- ❌ Wrong
MATCH path = (a)-[:PROXIMA_AMIZADE* {de: u.email}*0..]->(b)

-- ✅ Correct
MATCH path = (a)-[:PROXIMA_AMIZADE*0..]->(b)
WHERE ALL(r IN relationships(path) WHERE r.de = u.email)
```

---

### ❌ Error: Constraints syntax on Neo4j Aura

**Symptom:** Error when creating constraints using old syntax.

**Cause:** Neo4j Aura runs version 5.x, which requires the `FOR ... REQUIRE ... IS` syntax.

**Fix:**
```cypher
-- ❌ Old syntax (Neo4j 3.x/4.x)
CREATE CONSTRAINT ON (u:Usuario) ASSERT u.email IS UNIQUE

-- ✅ Current syntax (Neo4j 5.x)
CREATE CONSTRAINT usuario_email_unique IF NOT EXISTS
FOR (u:Usuario) REQUIRE u.email IS UNIQUE
```

---

### ⚠️ Warning: APOC not available on Aura Free

**Symptom:** `There is no procedure with the name apoc.date.format`

**Cause:** Neo4j Aura Free Tier does not include the APOC library by default.

**Fix:** All queries in this project were rewritten using only native Cypher functions (`split()`, `date()`, `duration.between()`), eliminating any APOC dependency.

---

### ⚠️ Performance: shortestPath with many nodes

**Symptom:** Slow shortest path query on larger graphs.

**Cause:** `shortestPath()` without a depth limit can explore the entire graph.

**Fix:** Always define a maximum hop limit (e.g. `*1..6`) and ensure the `dataNascimento` indexes are created before running marketing queries.

---

### ⚠️ Duplicate results with `*0..` in linked list queries

**Symptom:** The same user appeared multiple times with decreasing counts (6, 6, 6, 5, 5, 5...).

**Cause:** The `*0..` pattern generates one result per possible path length (0, 1, 2... up to N), not just the longest path.

**Fix:** Use `MIN(length(path))` to collapse all paths into a single result per user:

```cypher
-- ❌ Wrong
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(fim:Post:PostFinal)
RETURN u.nome, length(path) + 1 AS TotalPosts

-- ✅ Correct
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(fim:Post)
WHERE fim:PostFinal
WITH u, MIN(length(path)) + 1 AS TotalPosts
RETURN u.nome, TotalPosts
```

---

## 🛠️ Technologies

- [Neo4j Aura](https://neo4j.com/cloud/aura/) — Managed graph database in the cloud
- [Cypher Query Language](https://neo4j.com/docs/cypher-manual/current/) — Neo4j's native declarative query language
- [Neo4j Browser](https://neo4j.com/developer/neo4j-browser/) — Execution and visualization interface
- [Arrows.app](https://arrows.app/) — Visual graph modeling tool

---

## 👤 Author

Developed as a hands-on challenge for the **Graph Databases** track at [DIO — Digital Innovation One](https://www.dio.me/).

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](../LICENSE) file for details.
