# 📊 Queries de Negócio — Neo4j Social Network

> Documentação completa das queries Cypher do projeto, incluindo enunciado, código comentado, resultado esperado e registro das correções aplicadas durante o desenvolvimento.

---

## 📋 Índice

- [Queries Principais (Q1–Q11)](#queries-principais)
- [Queries de Listas Ligadas (QL1–QL6)](#queries-de-listas-ligadas)
- [Histórico de Correções](#histórico-de-correções)

---

## Queries Principais

---

### Q1 — Alcance de Marketing com APOC

**Pergunta de negócio:**
> Para uma ação de marketing direcionada a jovens de 25 a 35 anos ligados ao Roberto, qual o mínimo de saltos necessários para atingir cada alvo?

**Observação:** Requer a biblioteca APOC instalada. Para Neo4j Aura Free, use a **Q2** que não depende de APOC.

```cypher
// Q1: Caminho mínimo até jovens 25-35 anos ligados ao Roberto (com APOC)
// Converte dataNascimento (dd/MM/yyyy) para date() usando apoc.date
MATCH (roberto:Usuario {email:'roberto@email.com'})
MATCH (alvo:Usuario)
WHERE alvo <> roberto
  AND date(apoc.date.format(apoc.date.parse(alvo.dataNascimento, 'ms', 'dd/MM/yyyy'), 'ms', 'yyyy-MM-dd'))
      >= date('1991-03-14')
  AND date(apoc.date.format(apoc.date.parse(alvo.dataNascimento, 'ms', 'dd/MM/yyyy'), 'ms', 'yyyy-MM-dd'))
      <= date('2001-03-14')
MATCH path = shortestPath((roberto)-[*1..6]-(alvo))
RETURN alvo.nome            AS Nome,
       alvo.dataNascimento  AS DataNascimento,
       length(path)         AS SaltosMinimos,
       [n IN nodes(path) WHERE n:Usuario | n.nome] AS CaminhoUsuarios
ORDER BY SaltosMinimos ASC;
```

**Resultado esperado:**

| Nome | DataNascimento | SaltosMinimos | CaminhoUsuarios |
|---|---|---|---|
| João Marins | 29/11/1990 | 1 | [Roberto Alves, João Marins] |
| Thiago Ferreira | 25/02/1989 | 1 | [Roberto Alves, Thiago Ferreira] |
| Renato Gomes | 28/03/1987 | 1 | [Roberto Alves, Renato Gomes] |
| Ana Schultz | 17/03/1995 | 1 | [Roberto Alves, Ana Schultz] |
| Guilherme Costa | 14/07/1993 | 2 | [Roberto Alves, João Marins, Guilherme Costa] |
| ... | ... | ... | ... |

---

### Q2 — Alcance de Marketing sem APOC ✅ (Recomendada)

**Pergunta de negócio:**
> Mesma pergunta da Q1, porém usando apenas funções nativas do Cypher — compatível com Neo4j Aura Free Tier.

> ⚠️ **Esta é a versão corrigida.** Veja o histórico de correções ao final do documento.

```cypher
// Q2: Caminho mínimo até jovens 25-35 anos ligados ao Roberto (sem APOC)
// Usa split() nativo para converter dd/MM/yyyy → date(yyyy-MM-dd)
MATCH (roberto:Usuario {email:'roberto@email.com'})
MATCH (alvo:Usuario)
WHERE alvo <> roberto

// Passo 1: quebrar a string de data em partes [dd, MM, yyyy]
WITH roberto, alvo,
     split(alvo.dataNascimento, '/') AS partes

// Passo 2: reconstruir no formato aceito por date() → yyyy-MM-dd
WITH roberto, alvo, partes,
     date(partes[2] + '-' + partes[1] + '-' + partes[0]) AS dtNasc

// Passo 3: calcular idade com duration.between()
WITH roberto, alvo, dtNasc,
     duration.between(dtNasc, date('2026-03-14')).years AS idade

// Passo 4: filtrar faixa etária 25–35 anos
WHERE idade >= 25 AND idade <= 35

// Passo 5: encontrar o caminho mais curto (máx. 6 saltos)
MATCH path = shortestPath((roberto)-[*1..6]-(alvo))

RETURN alvo.nome           AS Nome,
       alvo.dataNascimento AS DataNascimento,
       idade               AS Idade,
       length(path)        AS SaltosMinimos,
       [n IN nodes(path) WHERE n:Usuario | n.nome] AS CaminhoUsuarios
ORDER BY SaltosMinimos ASC;
```

**Resultado esperado:**

| Nome | Idade | SaltosMinimos | CaminhoUsuarios |
|---|---|---|---|
| Ana Schultz | 31 | 1 | [Roberto Alves, Ana Schultz] |
| João Marins | 35 | 1 | [Roberto Alves, João Marins] |
| Thiago Ferreira | 37 | 1 | [Roberto Alves, Thiago Ferreira] |
| Renato Gomes | 39 | 1 | [Roberto Alves, Renato Gomes] |
| Guilherme Costa | 32 | 2 | [Roberto Alves, João Marins, Guilherme Costa] |
| Mariana Serena | 28 | 2 | [Roberto Alves, Ana Schultz, Mariana Serena] |
| ... | ... | ... | ... |

---

### Q3 — Amigos Diretos de um Usuário

**Pergunta de negócio:**
> Quem são os amigos diretos do Roberto? (1 salto)

```cypher
// Q3: Lista os amigos imediatos de um usuário
// Relacionamento E_AMIGO_DE é bidirecional (dois arcos direcionados)
// Usamos --> para pegar apenas os arcos de saída e evitar duplicatas
MATCH (roberto:Usuario {email:'roberto@email.com'})-[:E_AMIGO_DE]->(amigo:Usuario)
RETURN amigo.nome            AS Amigo,
       amigo.dataNascimento  AS Nascimento
ORDER BY amigo.nome;
```

**Resultado esperado:**

| Amigo | Nascimento |
|---|---|
| Ana Schultz | 17/03/1995 |
| João Marins | 29/11/1990 |
| Renato Gomes | 28/03/1987 |
| Thiago Ferreira | 25/02/1989 |

---

### Q4 — Ações de um Usuário nos Posts

**Pergunta de negócio:**
> Quais posts o Roberto curtiu, comentou ou compartilhou, e quando?

```cypher
// Q4: Recupera todas as interações de um usuário com posts
// Atravessa o nó intermediário Acao para chegar ao Post
MATCH (roberto:Usuario {email:'roberto@email.com'})
      -[r:CURTIU_O_POST|COMENTOU_O_POST|COMPARTILHOU_O_POST]->
      (a:Acao)-[:PERTENCE_AO_POST]->(p:Post)
RETURN type(r)    AS TipoAcao,
       p.titulo   AS Post,
       a.dataHora AS DataHora
ORDER BY a.dataHora;
```

**Resultado esperado:**

| TipoAcao | Post | DataHora |
|---|---|---|
| CURTIU_O_POST | Networking que funciona de verdade | 06/03/2024 11h00'00'' |

---

### Q5 — Comunidades Mais Ativas por Número de Posts

**Pergunta de negócio:**
> Quais comunidades concentram mais conteúdo publicado?

```cypher
// Q5: Conta os posts vinculados a cada comunidade
// Posts se relacionam a comunidades via PERTENCE_A
MATCH (p:Post)-[:PERTENCE_A]->(c:Comunidade)
RETURN c.nome      AS Comunidade,
       count(p)    AS TotalPosts
ORDER BY TotalPosts DESC;
```

**Resultado esperado:**

| Comunidade | TotalPosts |
|---|---|
| Dev & Café | 5 |
| Investidores Jovens | 5 |
| Foodies SP | 4 |
| Galera do Rock | 4 |
| Pedalando pela Vida | 3 |

---

### Q6 — Usuários que Participam de Mais de Uma Comunidade

**Pergunta de negócio:**
> Quais usuários são membros de múltiplas comunidades? (perfis mais socialmente ativos)

```cypher
// Q6: Identifica usuários multissociais
// Agrupa por usuário e filtra quem tem mais de 1 comunidade
MATCH (u:Usuario)-[:PERTENCE_A]->(c:Comunidade)
WITH u, count(c) AS totalComunidades
WHERE totalComunidades > 1
RETURN u.nome          AS Usuario,
       totalComunidades AS TotalComunidades
ORDER BY totalComunidades DESC;
```

**Resultado esperado:**

| Usuario | TotalComunidades |
|---|---|
| Ana Schultz | 2 |
| Beatriz Nunes | 2 |
| Lucas Mendes | 2 |
| Guilherme Costa | 2 |
| Mariana Serena | 2 |
| Renato Gomes | 2 |
| Thiago Ferreira | 2 |
| Joao Marins | 2 |

---

### Q7 — Posts com Maior Engajamento

**Pergunta de negócio:**
> Quais posts acumularam mais interações (curtidas + comentários + compartilhamentos)?

```cypher
// Q7: Ranking de engajamento por post
// Conta todos os nós Acao vinculados a cada post, independente do tipo
MATCH (a:Acao)-[:PERTENCE_AO_POST]->(p:Post)
RETURN p.titulo         AS Post,
       p.autor          AS Autor,
       count(a)         AS TotalInteracoes
ORDER BY TotalInteracoes DESC
LIMIT 10;
```

**Resultado esperado:**

| Post | Autor | TotalInteracoes |
|---|---|---|
| Como diversificar sua carteira em 2024 | Roberto Alves | 4 |
| Top 10 álbuns de Rock dos anos 90 | Ana Schultz | 3 |
| Pedalada até Embu das Artes | Carlos Eduardo | 3 |
| Docker do zero: guia prático | Guilherme Costa | 3 |
| ... | ... | ... |

---

### Q8 — Grau de Conexão de Cada Usuário

**Pergunta de negócio:**
> Quais usuários têm mais amizades? (influenciadores potenciais da rede)

```cypher
// Q8: Calcula o grau de saída de cada nó Usuario
// Conta relacionamentos E_AMIGO_DE de saída para evitar dupla contagem
MATCH (u:Usuario)-[:E_AMIGO_DE]->(outro:Usuario)
RETURN u.nome           AS Usuario,
       count(outro)     AS NumeroDeAmigos
ORDER BY NumeroDeAmigos DESC;
```

**Resultado esperado:**

| Usuario | NumeroDeAmigos |
|---|---|
| Roberto Alves | 4 |
| Guilherme Costa | 4 |
| Ana Schultz | 3 |
| Renato Gomes | 3 |
| João Marins | 3 |
| ... | ... |

---

### Q9 — Usuários sem Comunidade

**Pergunta de negócio:**
> Quais usuários não pertencem a nenhuma comunidade? (potencial para campanhas de engajamento)

```cypher
// Q9: Filtra usuários sem nenhum relacionamento PERTENCE_A com Comunidade
// NOT (...) verifica ausência de padrão no grafo
MATCH (u:Usuario)
WHERE NOT (u)-[:PERTENCE_A]->(:Comunidade)
RETURN u.nome AS UsuarioSemComunidade;
```

**Resultado esperado:**

| UsuarioSemComunidade |
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

### Q10 — Pontes Sociais (Betweenness Simplificado)

**Pergunta de negócio:**
> Quais usuários funcionam como pontes entre grupos distintos? Quem conecta partes da rede que não se conectariam de outra forma?

```cypher
// Q10: Identifica nós intermediários em caminhos curtos
// Conta quantos destinos distintos cada nó intermediário ajuda a alcançar
// a partir do Roberto — aproximação de betweenness centrality
MATCH (roberto:Usuario {email:'roberto@email.com'}), (alvo:Usuario)
WHERE alvo <> roberto
MATCH path = shortestPath((roberto)-[*1..5]-(alvo))
WHERE length(path) > 2

// Extrai os nós intermediários (exclui início e fim do path)
UNWIND nodes(path)[1..-1] AS intermediario
WITH intermediario, count(DISTINCT alvo) AS caminhosCobertos
WHERE intermediario:Usuario
RETURN intermediario.nome  AS PonteSocial,
       caminhosCobertos     AS DestinosAlcancados
ORDER BY caminhosCobertos DESC
LIMIT 5;
```

**Resultado esperado:**

| PonteSocial | DestinosAlcancados |
|---|---|
| João Marins | 8 |
| Ana Schultz | 7 |
| Renato Gomes | 6 |
| Thiago Ferreira | 4 |
| Guilherme Costa | 4 |

---

### Q11 — Sugestão de Amigos ⭐

**Pergunta de negócio:**
> Quem o usuário provavelmente conhece mas ainda não é amigo? ("Pessoas que você talvez conheça")

```cypher
// Q11: Sugestão de amigos baseada em amigos de amigos
//
// Lógica:
//   Eu → Amigo Direto → Candidato (amigo do meu amigo)
//
// Critérios:
//   - Candidato não pode ser o próprio usuário
//   - Candidato não pode já ser amigo direto
//   - Quanto mais amigos em comum, mais relevante a sugestão
MATCH (eu:Usuario {email:'roberto@email.com'})

// Passo 1: encontra todos os amigos diretos
MATCH (eu)-[:E_AMIGO_DE]->(amigoDireto:Usuario)

// Passo 2: a partir de cada amigo direto, alcança os amigos dele
MATCH (amigoDireto)-[:E_AMIGO_DE]->(candidato:Usuario)

// Passo 3: exclui o próprio usuário e amigos já existentes
WHERE candidato <> eu
  AND NOT (eu)-[:E_AMIGO_DE]->(candidato)

// Passo 4: agrega — coleta amigos em comum e conta
WITH eu, candidato,
     collect(DISTINCT amigoDireto.nome) AS amigoEmComum,
     count(DISTINCT amigoDireto)        AS totalEmComum

ORDER BY totalEmComum DESC

RETURN candidato.nome          AS SugestaoDAmigo,
       totalEmComum             AS AmigoEmComumCount,
       amigoEmComum             AS QuaisSaoOsAmigosEmComum
LIMIT 10;
```

**Resultado esperado:**

| SugestaoDAmigo | AmigoEmComumCount | QuaisSaoOsAmigosEmComum |
|---|---|---|
| Guilherme Costa | 2 | [João Marins, Thiago Ferreira] |
| Juliana Pinto | 2 | [Renato Gomes, João Marins] |
| Diego Carvalho | 1 | [Renato Gomes] |
| Camila Borges | 1 | [Ana Schultz] |
| Mariana Serena | 1 | [Ana Schultz] |

---

## Queries de Listas Ligadas

---

### QL1 — Feed Completo de um Usuário

**Pergunta de negócio:**
> Quais são os posts de um usuário em ordem cronológica de publicação?

```cypher
// QL1: Percorre a lista ligada de posts de um usuário
// PRIMEIRO_POST aponta para o início da cadeia
// PROXIMO_POST* percorre todos os elos até o fim
MATCH (u:Usuario {email:'ana@email.com'})-[:PRIMEIRO_POST]->(inicio:Post)
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(post:Post)
RETURN post.titulo  AS Titulo,
       post.autor   AS Autor
ORDER BY length(path) ASC;
```

**Resultado esperado:**

| Titulo | Autor |
|---|---|
| Top 10 álbuns de Rock dos anos 90 | Ana Schultz |
| Show do Foo Fighters foi incrível! | Ana Schultz |
| Bandas independentes que você precisa conhecer | Ana Schultz |
| Tocando violão depois de 2 anos | Ana Schultz |

---

### QL2 — Acessar o Nº Post do Feed

**Pergunta de negócio:**
> Qual é o segundo post publicado por um usuário?

```cypher
// QL2: Acessa diretamente o Nº elemento da lista ligada
// *1 = exatamente 1 salto a partir do início = 2º post
// Altere o número para acessar qualquer posição
MATCH (u:Usuario {email:'mariana@email.com'})-[:PRIMEIRO_POST]->(inicio:Post)
MATCH (inicio)-[:PROXIMO_POST*1]->(segundoPost:Post)
RETURN segundoPost.titulo AS SegundoPost;
```

**Resultado esperado:**

| SegundoPost |
|---|
| Receita: Risoto de cogumelos selvagens |

---

### QL3 — Inserir Novo Post no Final do Feed

**Pergunta de negócio:**
> Como adicionar um novo post ao final da lista ligada de um usuário mantendo a integridade da cadeia?

```cypher
// QL3: Manutenção da lista ligada — inserção no final
//
// Passos:
//   1. Encontra o PostFinal atual (último da cadeia)
//   2. Remove a label :PostFinal do atual último
//   3. Conecta o atual último ao novo post
//   4. Marca o novo post como :PostFinal
MATCH (u:Usuario {email:'ana@email.com'})-[:PRIMEIRO_POST]->(inicio:Post)
MATCH (inicio)-[:PROXIMO_POST*0..]->(ultimo:Post:PostFinal)
MATCH (novoPost:Post {titulo:'Tocando violão depois de 2 anos'})
REMOVE ultimo:PostFinal
CREATE (ultimo)-[:PROXIMO_POST {ordem: 99}]->(novoPost)
SET novoPost:PostFinal
RETURN novoPost.titulo AS NovoUltimoPost;
```

---

### QL4 — Histórico de Amizades de um Usuário ✅ (Corrigida)

**Pergunta de negócio:**
> Em qual ordem cronológica o Roberto fez amizades na rede?

> ⚠️ **Esta é a versão corrigida.** Veja o histórico de correções ao final do documento.

```cypher
// QL4: Percorre a lista ligada de amizades de um usuário
//
// A propriedade {de} no relacionamento PROXIMA_AMIZADE identifica
// a qual usuário aquela cadeia pertence, evitando contaminação
// entre listas de usuários diferentes que compartilham os mesmos nós.
//
// CORREÇÃO APLICADA: filtro de propriedade movido para WHERE com ALL()
// pois não é possível combinar {propriedade} e *quantificador no mesmo []
MATCH (u:Usuario {email:'roberto@email.com'})-[:PRIMEIRA_AMIZADE]->(primeiro:Usuario)
MATCH path = (primeiro)-[:PROXIMA_AMIZADE*0..]->(amigo:Usuario)
WHERE ALL(r IN relationships(path) WHERE r.de = 'roberto@email.com')
RETURN amigo.nome            AS Amigo,
       amigo.dataNascimento  AS Nascimento,
       length(path) + 1      AS OrdemCronologica
ORDER BY OrdemCronologica ASC;
```

**Resultado esperado:**

| Amigo | Nascimento | OrdemCronologica |
|---|---|---|
| Ana Schultz | 17/03/1995 | 1 |
| João Marins | 29/11/1990 | 2 |
| Thiago Ferreira | 25/02/1989 | 3 |
| Renato Gomes | 28/03/1987 | 4 |

---

### QL5 — Amigo Mais Recente de Cada Usuário ✅ (Corrigida)

**Pergunta de negócio:**
> Quem foi a amizade mais recente de cada usuário na rede?

> ⚠️ **Esta é a versão corrigida.** Veja o histórico de correções ao final do documento.

```cypher
// QL5: Encontra o último nó de cada lista ligada de amizades
//
// Estratégia: percorre a lista e identifica o nó que NÃO possui
// um próximo elemento — esse é o último da cadeia.
//
// CORREÇÃO APLICADA: mesma correção da QL4 — filtro movido para WHERE com ALL()
MATCH (u:Usuario)-[:PRIMEIRA_AMIZADE]->(primeiro:Usuario)
MATCH path = (primeiro)-[:PROXIMA_AMIZADE*0..]->(ultimo:Usuario)
WHERE ALL(r IN relationships(path) WHERE r.de = u.email)
  AND NOT (ultimo)-[:PROXIMA_AMIZADE {de: u.email}]->()
RETURN u.nome       AS Usuario,
       ultimo.nome  AS AmigoMaisRecente;
```

**Resultado esperado:**

| Usuario | AmigoMaisRecente |
|---|---|
| Roberto Alves | Renato Gomes |
| Guilherme Costa | Vinícius Andrade |
| Ana Schultz | Mariana Serena |
| João Marins | Beatriz Nunes |
| ... | ... |

---

### QL6 — Tamanho do Feed de Cada Usuário ✅ (Corrigida)

**Pergunta de negócio:**
> Quantos posts cada usuário publicou? (baseado na lista ligada)

> ⚠️ **Esta é a versão corrigida.** Veja o histórico de correções ao final do documento.

```cypher
// QL6: Conta o total de posts no feed de cada usuário
//
// CORREÇÃO APLICADA: uso de MIN(length(path)) para evitar múltiplas linhas
// por usuário. O *0.. gerava um path por comprimento (0,1,2...N),
// resultando em linhas duplicadas para o mesmo usuário.
// MIN() colapsa todos os paths no menor (= caminho direto ao PostFinal).
MATCH (u:Usuario)-[:PRIMEIRO_POST]->(inicio:Post)
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(fim:Post)
WHERE fim:PostFinal
WITH u, MIN(length(path)) + 1 AS TotalPosts
RETURN u.nome    AS Usuario,
       TotalPosts
ORDER BY TotalPosts DESC;
```

**Resultado esperado:**

| Usuario | TotalPosts |
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

## Histórico de Correções

Registro das dificuldades encontradas durante o desenvolvimento e como foram resolvidas — erros reais de quem trabalhou com Neo4j Cypher na prática.

---

### Correção 1 — Q2: Encadeamento de métodos de string

**Erro:**
```
Invalid input '(', expected: an expression, ')' or ','
(line 6, column 57)
"date(replace(alvo.dataNascimento, '/', '-').split('-')[2] + '-' +"
```

**Causa:** O Cypher não suporta encadeamento de métodos no estilo `.split()` como Python ou JavaScript.

**Antes (❌):**
```cypher
date(replace(alvo.dataNascimento, '/', '-').split('-')[2] + '-' +
     replace(alvo.dataNascimento, '/', '-').split('-')[1] + '-' +
     replace(alvo.dataNascimento, '/', '-').split('-')[0])
```

**Depois (✅):**
```cypher
WITH split(alvo.dataNascimento, '/') AS partes
WITH date(partes[2] + '-' + partes[1] + '-' + partes[0]) AS dtNasc
```

**Regra aprendida:** No Cypher, funções de string são standalone. Resultados intermediários devem ser capturados via `WITH`.

---

### Correção 2 — QL4 e QL5: Filtro de propriedade com quantificador

**Erro:**
```
Invalid input '*', expected: 'WHERE' or ']'
(line 2, column 68)
"MATCH path = (primeiro)-[:PROXIMA_AMIZADE* {de:'roberto@email.com'}*0..]->(amigo:Usuario)"
```

**Causa:** No Cypher, não é possível combinar filtro de propriedade `{chave: valor}` e quantificador `*N..` dentro do mesmo colchete `[...]` de relacionamento.

**Antes (❌):**
```cypher
MATCH path = (a)-[:PROXIMA_AMIZADE* {de: u.email}*0..]->(b)
```

**Depois (✅):**
```cypher
MATCH path = (a)-[:PROXIMA_AMIZADE*0..]->(b)
WHERE ALL(r IN relationships(path) WHERE r.de = u.email)
```

**Regra aprendida:** Filtros de propriedade em relacionamentos com quantificadores sempre vão para o `WHERE` usando o predicado `ALL()`.

---

### Correção 3 — QL6: Duplicação de resultados com `*0..`

**Sintoma:** Ana Schultz aparecia 6 vezes seguidas com contagens decrescentes (6, 6, 6, 5, 5, 5...).

**Causa:** O padrão `*0..` gera um resultado para cada comprimento de caminho possível (0, 1, 2... até N), não apenas para o caminho mais longo. Para uma lista de 4 posts, isso gerava 4 linhas para o mesmo usuário.

**Antes (❌):**
```cypher
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(fim:Post:PostFinal)
RETURN u.nome, length(path) + 1 AS TotalPosts
```

**Depois (✅):**
```cypher
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(fim:Post)
WHERE fim:PostFinal
WITH u, MIN(length(path)) + 1 AS TotalPosts
RETURN u.nome, TotalPosts
```

**Regra aprendida:** Ao usar `*0..` para percorrer listas ligadas e precisar do comprimento total, sempre use `MIN()` ou `MAX()` no `WITH` para colapsar os múltiplos paths em um único resultado por nó.
