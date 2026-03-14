# 🕸️ Neo4j Social Network — Grafo de Rede Social

> Projeto desenvolvido como parte do desafio prático da [DIO](https://www.dio.me/) na trilha de **Banco de Dados em Grafos com Neo4j**.  
> Simula uma rede social completa com usuários, posts, interações, comunidades, listas ligadas e queries de negócio inteligentes.

---

## 📋 Índice

- [Contexto e Motivação](#-contexto-e-motivação)
- [Por que Grafos?](#-por-que-grafos)
- [Modelo do Grafo](#-modelo-do-grafo)
- [Estrutura do Repositório](#-estrutura-do-repositório)
- [Pré-requisitos](#-pré-requisitos)
- [Como Executar](#-como-executar)
- [Dataset](#-dataset)
- [Queries de Negócio](#-queries-de-negócio)
- [Listas Ligadas e Índices](#-listas-ligadas-e-índices)
- [Troubleshooting](#-troubleshooting)
- [Tecnologias](#-tecnologias)
- [Autor](#-autor)

---

## 🎯 Contexto e Motivação

Redes sociais são, por natureza, **grafos**: pessoas são nós, relacionamentos são arestas. Modelar esse domínio em um banco relacional exigiria múltiplas tabelas de junção e queries com `JOIN` profundos para responder perguntas simples como *"quais amigos do Roberto têm entre 25 e 35 anos?"*.

Este projeto constrói uma rede social simulada com:

- **20 usuários** com perfis realistas
- **50 posts** distribuídos entre os usuários
- **5 comunidades** temáticas
- **Interações** (curtidas, comentários, compartilhamentos) como nós intermediários
- **Listas ligadas** para feed cronológico e histórico de amizades
- **11 queries de negócio** comentadas, incluindo análise de alcance para marketing

---

## 🔍 Por que Grafos?

| Cenário | Banco Relacional | Neo4j (Grafo) |
|---|---|---|
| Amigos de amigos | 2+ JOINs aninhados | 1 padrão `(a)-[:E_AMIGO_DE*2]->(b)` |
| Caminho mínimo entre usuários | Algoritmo externo | `shortestPath()` nativo |
| Sugestão de amigos | CTE recursiva complexa | Query simples de 2 saltos |
| Comunidades e pertencimento | Tabela associativa | Relacionamento direto `PERTENCE_A` |
| Feed cronológico | `ORDER BY` em tabela | Lista ligada com `PROXIMO_POST` |

Em grafos, **a estrutura dos dados é o modelo** — não há impedância entre o domínio e o armazenamento.

---

## 🗺️ Modelo do Grafo

### Visualizando o schema no Neo4j

Após importar os dados, execute no **Neo4j Browser** ou **Aura Console**:

```cypher
CALL db.schema.visualization()
```

Isso gera um diagrama visual interativo com todos os labels e tipos de relacionamento do seu grafo.

### Labels (Nós)

| Label | Descrição | Propriedades-chave |
|---|---|---|
| `Usuario` | Perfil de usuário | `id`, `nome`, `email`, `dataNascimento`, `dataCadastro` |
| `Post` | Publicação de conteúdo | `titulo`, `conteudo`, `autor` |
| `Acao` | Nó intermediário de interação | `tipo`, `dataHora` |
| `Curtida` | Sublabel de Acao | — |
| `Comentario` | Sublabel de Acao (+ `texto`) | `texto` |
| `Compartilhamento` | Sublabel de Acao | — |
| `Comunidade` | Grupo temático | `nome`, `tema`, `responsavel` |

### Tipos de Relacionamento

| Relacionamento | De → Para | Propriedades |
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

### Diagrama simplificado

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

> 💡 **Dica:** Use o [Arrows.app](https://arrows.app/) para desenhar e exportar um diagrama visual do modelo antes de apresentar o projeto.

---

## 📁 Estrutura do Repositório

```
neo4j-social-network/
│
├── cypher/
│   ├── 01_rede_social_neo4j.cypher          # Estrutura principal: constraints, nós e relacionamentos
│   └── 02_listas_e_indices.cypher           # Listas ligadas, índices e queries das listas
│
├── queries/
│   └── queries_negocio.md                   # 11 queries + 6 queries de listas com enunciado,
│                                            # código comentado, resultado esperado e correções
│
├── screenshots/
│   ├── Queries_Screenshots/                 # Prints das queries Q1–Q11 no Neo4j Browser
│   ├── Queries_Lists_ScreenShots/           # Prints das queries QL1–QL6 (listas ligadas)
│   
│
├── .gitignore                               # Ignora credenciais, dados locais e arquivos de SO
├── README.md                                # Este arquivo
└── LICENSE                                  # Licença MIT
```

---

## ⚙️ Pré-requisitos

- **Neo4j Aura** (gratuito) — [console.neo4j.io](https://console.neo4j.io) **ou** Neo4j Desktop instalado localmente
- **Git** instalado
- Navegador moderno (para o Neo4j Browser)

> Este projeto **não utiliza APOC** para manter compatibilidade total com o Neo4j Aura Free Tier.

---

## 🚀 Como Executar

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/neo4j-social-network.git
cd neo4j-social-network
```

### 2. Crie uma instância no Neo4j Aura

1. Acesse [console.neo4j.io](https://console.neo4j.io)
2. Clique em **New Instance** → escolha **AuraDB Free**
3. Anote o **URI**, **usuário** (`neo4j`) e a **senha** gerada
4. Aguarde o status ficar **Running** (pode levar alguns minutos)

### 3. Abra o Neo4j Browser

1. Na tela da instância, clique em **Open** → **Neo4j Browser**
2. Faça login com suas credenciais

### 4. Execute os scripts na ordem correta

> ⚠️ **Importante:** Execute cada seção separadamente, aguardando a confirmação de sucesso antes de prosseguir para a próxima.

**Passo 4.1 — Constraints e Índices Base**

Copie e cole apenas a **Seção 0** do arquivo `01_rede_social_neo4j.cypher` no editor do Browser e clique em ▶️ Run.

**Passo 4.2 — Criação dos Nós**

Execute as seções na seguinte ordem:
- Seção 1: Usuários
- Seção 2: Comunidades
- Seção 3: Posts

**Passo 4.3 — Relacionamentos**

Execute as seções na seguinte ordem:
- Seção 4: Amizades (`E_AMIGO_DE`)
- Seção 5: Postagens (`POSTOU`)
- Seção 6: Ações (Curtidas, Comentários, Compartilhamentos)
- Seção 7 e 8: Membros e Posts das Comunidades

**Passo 4.4 — Listas Ligadas e Índices Adicionais**

Execute o arquivo `02_listas_e_indices.cypher` completo, seção por seção:
- Seção 1: Índices
- Seção 2: Lista ligada de Feed
- Seção 3: Lista ligada de Histórico de Amizades

### 5. Verifique a importação

```cypher
// Contagem geral de nós por label
MATCH (n)
RETURN labels(n) AS Label, count(n) AS Total
ORDER BY Total DESC;
```

Resultado esperado:

| Label | Total |
|---|---|
| Acao | ~38 |
| Post | 50 |
| Usuario | 20 |
| Comunidade | 5 |

```cypher
// Contagem de relacionamentos por tipo
MATCH ()-[r]->()
RETURN type(r) AS Tipo, count(r) AS Total
ORDER BY Total DESC;
```

### 6. Visualize o schema

```cypher
CALL db.schema.visualization()
```

---

## 📊 Dataset

O dataset é sintético e foi criado para simular comportamentos reais de uma rede social brasileira. Todos os nomes, emails e IDs são fictícios.

### Usuários (amostra)

| Nome | Email | Nascimento | Comunidades |
|---|---|---|---|
| Roberto Alves | roberto@email.com | 05/08/1988 | Investidores Jovens |
| Ana Schultz | ana@email.com | 17/03/1995 | Galera do Rock, Foodies SP |
| Guilherme Costa | guilherme@email.com | 14/07/1993 | Dev & Café, Investidores Jovens |
| Mariana Serena | mariana@email.com | 02/12/1997 | Galera do Rock, Foodies SP |
| ... | ... | ... | ... |

### Comunidades

| Nome | Tema | Responsável |
|---|---|---|
| Galera do Rock | Música | Ana Schultz |
| Dev & Café | Tecnologia | Guilherme Costa |
| Pedalando pela Vida | Ciclismo | Carlos Eduardo |
| Foodies SP | Gastronomia | Mariana Serena |
| Investidores Jovens | Finanças | Roberto Alves |

---

## 🔎 Queries de Negócio

O projeto responde às seguintes perguntas de negócio através de Cypher:

### Q1–Q2 🎯 Alcance de Marketing
> *"Para uma ação de marketing direcionada a jovens de 25 a 35 anos ligados ao Roberto, qual o mínimo de saltos necessários para atingir cada alvo?"*

Utiliza `shortestPath()` combinado com cálculo de faixa etária via `split()` e `date()` nativos — sem necessidade de APOC.

```cypher
MATCH (roberto:Usuario {email:'roberto@email.com'})
MATCH (alvo:Usuario)
WHERE alvo <> roberto
WITH roberto, alvo, split(alvo.dataNascimento, '/') AS partes
WITH roberto, alvo, partes,
     date(partes[2] + '-' + partes[1] + '-' + partes[0]) AS dtNasc
WITH roberto, alvo, dtNasc,
     duration.between(dtNasc, date('2026-03-14')).years AS idade
WHERE idade >= 25 AND idade <= 35
MATCH path = shortestPath((roberto)-[*1..6]-(alvo))
RETURN alvo.nome AS Nome, idade AS Idade,
       length(path) AS SaltosMinimos,
       [n IN nodes(path) WHERE n:Usuario | n.nome] AS Caminho
ORDER BY SaltosMinimos ASC;
```

### Q3 — Amigos Diretos
> *"Quem são os amigos diretos de um usuário?"*

### Q4 — Ações do Usuário
> *"Quais posts um usuário curtiu, comentou ou compartilhou?"*

### Q5 — Comunidades Mais Ativas
> *"Quais comunidades concentram mais conteúdo?"*

### Q6 — Usuários Multissociais
> *"Quais usuários participam de mais de uma comunidade?"*

### Q7 — Posts Mais Engajados
> *"Quais posts têm mais interações (curtidas + comentários + compartilhamentos)?"*

### Q8 — Grau de Conexão
> *"Qual o número de amigos de cada usuário?"*

### Q9 — Usuários Isolados
> *"Quais usuários não pertencem a nenhuma comunidade?"*

### Q10 — Pontes Sociais
> *"Quais usuários funcionam como pontes entre grupos distintos?"*  
> *(Betweenness simplificado — conta quantos caminhos curtos passam por cada nó intermediário)*

### Q11 — Sugestão de Amigos ⭐
> *"Quem o usuário provavelmente conhece mas ainda não é amigo?"*  
> Baseado no padrão clássico de **amigos de amigos**, com contagem de conexões em comum.

```cypher
MATCH (eu:Usuario {email:'roberto@email.com'})
MATCH (eu)-[:E_AMIGO_DE]->(amigoDireto:Usuario)
MATCH (amigoDireto)-[:E_AMIGO_DE]->(candidato:Usuario)
WHERE candidato <> eu
  AND NOT (eu)-[:E_AMIGO_DE]->(candidato)
WITH eu, candidato,
     collect(DISTINCT amigoDireto.nome) AS amigoEmComum,
     count(DISTINCT amigoDireto)        AS totalEmComum
ORDER BY totalEmComum DESC
RETURN candidato.nome AS SugestaoDAmigo,
       totalEmComum   AS AmigoEmComumCount,
       amigoEmComum   AS QuaisSaoOsAmigosEmComum
LIMIT 10;
```

---

## 🔗 Listas Ligadas e Índices

### Por que listas ligadas em um grafo?

Em Neo4j, armazenar ordem em propriedades (ex: `ordem: 1`) exige ordenação na query. Uma **lista ligada nativa** usa a estrutura do próprio grafo para representar sequência, tornando operações como *"próximo post"* ou *"inserir no final do feed"* O(1) — sem ordenação.

### Feed de Posts (Lista Ligada)
```
Usuario -[:PRIMEIRO_POST]→ Post¹ -[:PROXIMO_POST]→ Post² -[:PROXIMO_POST]→ Post³:PostFinal
```
- Labels `:PostInicial` e `:PostFinal` marcam as pontas
- Inserção no final: deslocar `:PostFinal` e criar novo elo

### Histórico de Amizades (Lista Ligada)
```
Usuario -[:PRIMEIRA_AMIZADE]→ Amigo¹ -[:PROXIMA_AMIZADE {de}]→ Amigo² → ...
```
- Propriedade `de` (email do dono) evita contaminação entre listas de usuários diferentes
- Ordenado cronologicamente da amizade mais antiga para a mais recente

### Índices criados

| Índice | Campo | Justificativa |
|---|---|---|
| `idx_usuario_nascimento` | `Usuario.dataNascimento` | Query de marketing por faixa etária |
| `idx_post_autor` | `Post.autor` | Busca frequente por criador |
| `idx_acao_tipo` | `Acao.tipo` | Filtro por tipo de interação |
| `idx_comunidade_nome` | `Comunidade.nome` | Todos os MATCHes de comunidade |
| `idx_comunidade_tema` | `Comunidade.tema` | Busca por assunto |
| `idx_postou_data` | `rel POSTOU.dataPostagem` | Ordenação temporal |
| `idx_amizade_data` | `rel E_AMIGO_DE.dataInicio` | Histórico cronológico |

---

## 🩹 Troubleshooting

Dificuldades reais encontradas durante o desenvolvimento e como foram resolvidas:

---

### ❌ Erro: Encadeamento de métodos de string inválido

**Sintoma:**
```
Invalid input '(', expected: an expression, ')' or ','
"date(replace(alvo.dataNascimento, '/', '-').split('-')[2] + '-' +"
```

**Causa:** O Neo4j Cypher não suporta encadeamento de métodos no estilo `.split()` — isso é sintaxe de Python/JavaScript.

**Solução:** Usar `split()` como função standalone e atribuir o resultado a uma variável via `WITH`:

```cypher
-- ❌ Errado
date(replace(alvo.dataNascimento, '/', '-').split('-')[2] + ...)

-- ✅ Correto
WITH split(alvo.dataNascimento, '/') AS partes
WITH date(partes[2] + '-' + partes[1] + '-' + partes[0]) AS dtNasc
```

---

### ❌ Erro: Filtro de propriedade e quantificador no mesmo colchete

**Sintoma:**
```
Invalid input '*', expected: 'WHERE' or ']'
"MATCH path = (a)-[:PROXIMA_AMIZADE* {de:'email'}*0..]->(b)"
```

**Causa:** No Cypher, não é possível combinar `{propriedade: valor}` e `*0..` dentro do mesmo `[...]` de relacionamento.

**Solução:** Separar o filtro para uma cláusula `WHERE` usando o predicado `ALL()`:

```cypher
-- ❌ Errado
MATCH path = (a)-[:PROXIMA_AMIZADE* {de: u.email}*0..]->(b)

-- ✅ Correto
MATCH path = (a)-[:PROXIMA_AMIZADE*0..]->(b)
WHERE ALL(r IN relationships(path) WHERE r.de = u.email)
```

---

### ❌ Erro: Constraints no Neo4j Aura Free

**Sintoma:** Erro ao tentar criar constraints com sintaxe antiga.

**Causa:** O Neo4j Aura usa versão 5.x, que exige a sintaxe `FOR ... REQUIRE ... IS`.

**Solução:**
```cypher
-- ❌ Sintaxe antiga (Neo4j 3.x/4.x)
CREATE CONSTRAINT ON (u:Usuario) ASSERT u.email IS UNIQUE

-- ✅ Sintaxe atual (Neo4j 5.x)
CREATE CONSTRAINT usuario_email_unique IF NOT EXISTS
FOR (u:Usuario) REQUIRE u.email IS UNIQUE
```

---

### ⚠️ Aviso: APOC não disponível no Aura Free

**Sintoma:** `There is no procedure with the name apoc.date.format`

**Causa:** O Neo4j Aura Free Tier não inclui a biblioteca APOC por padrão.

**Solução:** Todas as queries deste projeto foram reescritas usando apenas funções nativas do Cypher (`split()`, `date()`, `duration.between()`), eliminando qualquer dependência de APOC.

---

### ⚠️ Performance: shortestPath com muitos nós

**Sintoma:** Query de caminho mínimo lenta em grafos maiores.

**Causa:** `shortestPath()` sem limite de profundidade pode explorar o grafo inteiro.

**Solução:** Sempre defina um limite máximo de saltos (ex: `*1..6`) e garanta que os índices em `dataNascimento` estejam criados antes de rodar as queries de marketing.

---

## 🛠️ Tecnologias

- [Neo4j Aura](https://neo4j.com/cloud/aura/) — Banco de dados em grafos gerenciado na nuvem
- [Cypher Query Language](https://neo4j.com/docs/cypher-manual/current/) — Linguagem declarativa nativa do Neo4j
- [Neo4j Browser](https://neo4j.com/developer/neo4j-browser/) — Interface de execução e visualização
- [Arrows.app](https://arrows.app/) — Ferramenta de modelagem visual de grafos

---

## 👤 Autor
Gabriel Andrade Cunha
Desenvolvido como desafio prático da trilha **Banco de Dados em Grafos** na [DIO — Digital Innovation One](https://www.dio.me/).

---

## 📄 Licença

Este projeto está licenciado sob a **MIT License** — veja o arquivo [LICENSE](LICENSE) para detalhes.
