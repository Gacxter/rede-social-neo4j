// =============================================================
// REDE SOCIAL — LISTAS LIGADAS + ÍNDICES
// Execute APÓS o arquivo principal rede_social_neo4j.cypher
// =============================================================


// =============================================================
// 1. ÍNDICES
// =============================================================
// Obs: constraints UNIQUE já criam índices implícitos para
// Usuario.email e Usuario.id. Os índices abaixo cobrem as
// propriedades mais consultadas nas queries do projeto.
// =============================================================

// --- Busca por faixa etária (query de marketing Q2) ---
CREATE INDEX idx_usuario_nascimento IF NOT EXISTS
FOR (u:Usuario) ON (u.dataNascimento);

// --- Busca de posts por autor ---
CREATE INDEX idx_post_autor IF NOT EXISTS
FOR (p:Post) ON (p.autor);

// --- Filtro de ações por tipo (Curtida / Comentario / Compartilhamento) ---
CREATE INDEX idx_acao_tipo IF NOT EXISTS
FOR (a:Acao) ON (a.tipo);

// --- Busca de comunidades por nome ---
CREATE INDEX idx_comunidade_nome IF NOT EXISTS
FOR (c:Comunidade) ON (c.nome);

// --- Busca de comunidades por tema ---
CREATE INDEX idx_comunidade_tema IF NOT EXISTS
FOR (c:Comunidade) ON (c.tema);

// --- Ordenação/filtro de posts por data de postagem (via rel POSTOU) ---
// Índice em relacionamento — suportado a partir do Neo4j 5.x
CREATE INDEX idx_postou_data IF NOT EXISTS
FOR ()-[r:POSTOU]-() ON (r.dataPostagem);

// --- Índice em relacionamento de amizade por data ---
CREATE INDEX idx_amizade_data IF NOT EXISTS
FOR ()-[r:E_AMIGO_DE]-() ON (r.dataInicio);


// =============================================================
// 2. LISTA LIGADA — FEED DE POSTS POR USUÁRIO (cronológico)
//
// Estrutura:
//   Usuario -[:PRIMEIRO_POST]-> Post -[:PROXIMO_POST]-> Post ...
//
// Representa o feed pessoal de cada usuário ordenado da
// postagem mais antiga para a mais recente.
// O primeiro nó da cadeia é marcado com :PostInicial
// O último nó da cadeia é marcado com :PostFinal
//
// Como funcionar:
//   - Buscar o feed de um usuário = seguir PRIMEIRO_POST → PROXIMO_POST*
//   - Inserir novo post = ajustar PROXIMO_POST do atual PostFinal
//   - Remover post = reconectar os vizinhos da cadeia
// =============================================================

// --- Roberto Alves ---
MATCH (u:Usuario {email:'roberto@email.com'})
MATCH (p1:Post {titulo:'Como diversificar sua carteira em 2024'})
MATCH (p2:Post {titulo:'Tesouro Direto vs CDB: qual escolher?'})
MATCH (p3:Post {titulo:'Meu primeiro aporte em FIIs'})
SET p1:PostInicial, p3:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2)
CREATE (p2)-[:PROXIMO_POST {ordem:2}]->(p3);

// --- Ana Schultz ---
MATCH (u:Usuario {email:'ana@email.com'})
MATCH (p1:Post {titulo:'Top 10 álbuns de Rock dos anos 90'})
MATCH (p2:Post {titulo:'Show do Foo Fighters foi incrível!'})
MATCH (p3:Post {titulo:'Bandas independentes que você precisa conhecer'})
MATCH (p4:Post {titulo:'Tocando violão depois de 2 anos'})
SET p1:PostInicial, p4:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2)
CREATE (p2)-[:PROXIMO_POST {ordem:2}]->(p3)
CREATE (p3)-[:PROXIMO_POST {ordem:3}]->(p4);

// --- João Marins ---
MATCH (u:Usuario {email:'joao@email.com'})
MATCH (p1:Post {titulo:'Dica de trilha no Parque Estadual'})
MATCH (p2:Post {titulo:'Receita de nhoque da minha vó'})
SET p1:PostInicial, p2:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2);

// --- Guilherme Costa ---
MATCH (u:Usuario {email:'guilherme@email.com'})
MATCH (p1:Post {titulo:'Por que aprendi TypeScript em 2024'})
MATCH (p2:Post {titulo:'Docker do zero: guia prático'})
MATCH (p3:Post {titulo:'Meu setup de home office 2024'})
SET p1:PostInicial, p3:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2)
CREATE (p2)-[:PROXIMO_POST {ordem:2}]->(p3);

// --- Mariana Serena ---
MATCH (u:Usuario {email:'mariana@email.com'})
MATCH (p1:Post {titulo:'Restaurante novo em SP que vale muito'})
MATCH (p2:Post {titulo:'Receita: Risoto de cogumelos selvagens'})
MATCH (p3:Post {titulo:'Vinhos naturais: vale a pena?'})
MATCH (p4:Post {titulo:'Mercado municipal: guia de compras'})
SET p1:PostInicial, p4:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2)
CREATE (p2)-[:PROXIMO_POST {ordem:2}]->(p3)
CREATE (p3)-[:PROXIMO_POST {ordem:3}]->(p4);

// --- Carlos Eduardo ---
MATCH (u:Usuario {email:'carlos@email.com'})
MATCH (p1:Post {titulo:'Pedalada até Embu das Artes'})
MATCH (p2:Post {titulo:'Manutenção básica da bike: aprenda você mesmo'})
MATCH (p3:Post {titulo:'Rota nova: Serra da Cantareira de bike'})
SET p1:PostInicial, p3:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2)
CREATE (p2)-[:PROXIMO_POST {ordem:2}]->(p3);

// --- Patrícia Lima ---
MATCH (u:Usuario {email:'patricia@email.com'})
MATCH (p1:Post {titulo:'Yoga pela manhã transforma o dia'})
MATCH (p2:Post {titulo:'Livros de autoconhecimento que recomendo'})
SET p1:PostInicial, p2:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2);

// --- Fernanda Rocha ---
MATCH (u:Usuario {email:'fernanda@email.com'})
MATCH (p1:Post {titulo:'Moda sustentável: onde comprar no Brasil'})
MATCH (p2:Post {titulo:'Thrift shopping em SP: guia completo'})
MATCH (p3:Post {titulo:'Minimalismo no guarda-roupa'})
SET p1:PostInicial, p3:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2)
CREATE (p2)-[:PROXIMO_POST {ordem:2}]->(p3);

// --- Lucas Mendes ---
MATCH (u:Usuario {email:'lucas@email.com'})
MATCH (p1:Post {titulo:'Corrida de rua: minha primeira meia maratona'})
MATCH (p2:Post {titulo:'Suplementação para corredores iniciantes'})
SET p1:PostInicial, p2:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2);

// --- Beatriz Nunes ---
MATCH (u:Usuario {email:'beatriz@email.com'})
MATCH (p1:Post {titulo:'Design thinking na prática'})
MATCH (p2:Post {titulo:'Portfólio de UX: o que não pode faltar'})
MATCH (p3:Post {titulo:'Figma tips que economizam horas'})
SET p1:PostInicial, p3:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2)
CREATE (p2)-[:PROXIMO_POST {ordem:2}]->(p3);

// --- Thiago Ferreira ---
MATCH (u:Usuario {email:'thiago@email.com'})
MATCH (p1:Post {titulo:'Investindo em cripto com responsabilidade'})
MATCH (p2:Post {titulo:'Bitcoin em 2024: perspectivas realistas'})
SET p1:PostInicial, p2:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2);

// --- Camila Borges ---
MATCH (u:Usuario {email:'camila@email.com'})
MATCH (p1:Post {titulo:'Intercâmbio em Lisboa: vale cada centavo'})
MATCH (p2:Post {titulo:'Aprender inglês sozinho em 2024'})
MATCH (p3:Post {titulo:'Viajar barato pela Europa: roteiro real'})
SET p1:PostInicial, p3:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2)
CREATE (p2)-[:PROXIMO_POST {ordem:2}]->(p3);

// --- Rafael Souza ---
MATCH (u:Usuario {email:'rafael@email.com'})
MATCH (p1:Post {titulo:'Primeiro emprego como dev: o que ninguém te conta'})
SET p1:PostInicial, p1:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1);

// --- Juliana Pinto ---
MATCH (u:Usuario {email:'juliana@email.com'})
MATCH (p1:Post {titulo:'Marketing digital para pequenos negócios'})
MATCH (p2:Post {titulo:'Criando conteúdo autêntico no Instagram'})
SET p1:PostInicial, p2:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2);

// --- Renato Gomes ---
MATCH (u:Usuario {email:'renato@email.com'})
MATCH (p1:Post {titulo:'Empreendedorismo após os 30: é possível'})
MATCH (p2:Post {titulo:'Gestão financeira para MEI'})
MATCH (p3:Post {titulo:'Networking que funciona de verdade'})
SET p1:PostInicial, p3:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2)
CREATE (p2)-[:PROXIMO_POST {ordem:2}]->(p3);

// --- Isabela Vieira ---
MATCH (u:Usuario {email:'isabela@email.com'})
MATCH (p1:Post {titulo:'Ansiedade na faculdade: como sobrevivi'})
MATCH (p2:Post {titulo:'Redes sociais e saúde mental'})
SET p1:PostInicial, p2:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2);

// --- Diego Carvalho ---
MATCH (u:Usuario {email:'diego@email.com'})
MATCH (p1:Post {titulo:'Futebol de várzea: a verdadeira escola'})
MATCH (p2:Post {titulo:'Como montar uma academia em casa gastando pouco'})
MATCH (p3:Post {titulo:'Treino de força para iniciantes: semana 1'})
SET p1:PostInicial, p3:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2)
CREATE (p2)-[:PROXIMO_POST {ordem:2}]->(p3);

// --- Larissa Matos ---
MATCH (u:Usuario {email:'larissa@email.com'})
MATCH (p1:Post {titulo:'Como estudar para concurso público trabalhando'})
MATCH (p2:Post {titulo:'Preparação para o ENEM depois dos 25'})
SET p1:PostInicial, p2:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2);

// --- Vinícius Andrade ---
MATCH (u:Usuario {email:'vinicius@email.com'})
MATCH (p1:Post {titulo:'Criando meu primeiro app com React Native'})
MATCH (p2:Post {titulo:'Open source: por que você deveria contribuir'})
SET p1:PostInicial, p2:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1)
CREATE (p1)-[:PROXIMO_POST {ordem:1}]->(p2);

// --- Helena Faria ---
MATCH (u:Usuario {email:'helena@email.com'})
MATCH (p1:Post {titulo:'Dançar ballet aos 20 anos: nunca é tarde'})
SET p1:PostInicial, p1:PostFinal
CREATE (u)-[:PRIMEIRO_POST]->(p1);


// =============================================================
// 3. LISTA LIGADA — HISTÓRICO DE AMIZADES POR USUÁRIO
//
// Estrutura:
//   Usuario -[:PRIMEIRA_AMIZADE]-> Usuario
//            -[:PROXIMA_AMIZADE {dataInicio}]-> Usuario ...
//
// Representa a linha do tempo de amizades de cada usuário,
// ordenada da amizade mais antiga para a mais recente.
// Permite percorrer o histórico social de qualquer nó.
//
// Nota: o relacionamento PROXIMA_AMIZADE carrega também a
// propriedade dataInicio para facilitar consultas temporais
// sem precisar voltar ao E_AMIGO_DE original.
// =============================================================

// --- Roberto Alves (amizades em ordem cronológica)
//     ana(2020) → joao(2021) → thiago(2021) → renato(2022)
MATCH (roberto:Usuario {email:'roberto@email.com'})
MATCH (ana:Usuario     {email:'ana@email.com'})
MATCH (joao:Usuario    {email:'joao@email.com'})
MATCH (thiago:Usuario  {email:'thiago@email.com'})
MATCH (renato:Usuario  {email:'renato@email.com'})
CREATE (roberto)-[:PRIMEIRA_AMIZADE]->(ana)
CREATE (ana)   -[:PROXIMA_AMIZADE {de:'roberto@email.com', dataInicio:'03/03/2021'}]->(joao)
CREATE (joao)  -[:PROXIMA_AMIZADE {de:'roberto@email.com', dataInicio:'19/08/2021'}]->(thiago)
CREATE (thiago)-[:PROXIMA_AMIZADE {de:'roberto@email.com', dataInicio:'27/01/2022'}]->(renato);

// --- Guilherme Costa
//     joao(2019) → lucas(2022) → rafael(2023) → vinicius(2023)
MATCH (guilherme:Usuario {email:'guilherme@email.com'})
MATCH (joao:Usuario      {email:'joao@email.com'})
MATCH (lucas:Usuario     {email:'lucas@email.com'})
MATCH (rafael:Usuario    {email:'rafael@email.com'})
MATCH (vinicius:Usuario  {email:'vinicius@email.com'})
CREATE (guilherme)-[:PRIMEIRA_AMIZADE]->(joao)
CREATE (joao)    -[:PROXIMA_AMIZADE {de:'guilherme@email.com', dataInicio:'22/10/2022'}]->(lucas)
CREATE (lucas)   -[:PROXIMA_AMIZADE {de:'guilherme@email.com', dataInicio:'14/02/2023'}]->(rafael)
CREATE (rafael)  -[:PROXIMA_AMIZADE {de:'guilherme@email.com', dataInicio:'05/12/2022'}]->(vinicius);

// --- Ana Schultz
//     roberto(2020) → camila(2020) → mariana(2021)
MATCH (ana:Usuario     {email:'ana@email.com'})
MATCH (roberto:Usuario {email:'roberto@email.com'})
MATCH (camila:Usuario  {email:'camila@email.com'})
MATCH (mariana:Usuario {email:'mariana@email.com'})
CREATE (ana)-[:PRIMEIRA_AMIZADE]->(roberto)
CREATE (roberto)-[:PROXIMA_AMIZADE {de:'ana@email.com', dataInicio:'11/11/2020'}]->(camila)
CREATE (camila) -[:PROXIMA_AMIZADE {de:'ana@email.com', dataInicio:'30/06/2021'}]->(mariana);

// --- Joao Marins
//     guilherme(2019) → beatriz(2019) → joao já coberto acima
MATCH (joao:Usuario      {email:'joao@email.com'})
MATCH (guilherme:Usuario {email:'guilherme@email.com'})
MATCH (beatriz:Usuario   {email:'beatriz@email.com'})
CREATE (joao)-[:PRIMEIRA_AMIZADE]->(guilherme)
CREATE (guilherme)-[:PROXIMA_AMIZADE {de:'joao@email.com', dataInicio:'08/12/2019'}]->(beatriz);

// --- Carlos Eduardo
//     diego(2020) → lucas(2022)
MATCH (carlos:Usuario {email:'carlos@email.com'})
MATCH (diego:Usuario  {email:'diego@email.com'})
MATCH (lucas:Usuario  {email:'lucas@email.com'})
CREATE (carlos)-[:PRIMEIRA_AMIZADE]->(diego)
CREATE (diego) -[:PROXIMA_AMIZADE {de:'carlos@email.com', dataInicio:'01/01/2022'}]->(lucas);

// --- Mariana Serena
//     ana(2021) → juliana(2021)
MATCH (mariana:Usuario {email:'mariana@email.com'})
MATCH (ana:Usuario     {email:'ana@email.com'})
MATCH (juliana:Usuario {email:'juliana@email.com'})
CREATE (mariana)-[:PRIMEIRA_AMIZADE]->(ana)
CREATE (ana)   -[:PROXIMA_AMIZADE {de:'mariana@email.com', dataInicio:'07/09/2021'}]->(juliana);

// --- Patrícia Lima
//     isabela(2022) → helena(2023)
MATCH (patricia:Usuario {email:'patricia@email.com'})
MATCH (isabela:Usuario  {email:'isabela@email.com'})
MATCH (helena:Usuario   {email:'helena@email.com'})
CREATE (patricia)-[:PRIMEIRA_AMIZADE]->(isabela)
CREATE (isabela) -[:PROXIMA_AMIZADE {de:'patricia@email.com', dataInicio:'29/05/2023'}]->(helena);

// --- Renato Gomes
//     roberto(2022) → diego(2021) → juliana(2022)
// Nota: ordenamos pela data de início da amizade (cronológica)
MATCH (renato:Usuario  {email:'renato@email.com'})
MATCH (roberto:Usuario {email:'roberto@email.com'})
MATCH (diego:Usuario   {email:'diego@email.com'})
MATCH (juliana:Usuario {email:'juliana@email.com'})
CREATE (renato)-[:PRIMEIRA_AMIZADE]->(diego)
CREATE (diego) -[:PROXIMA_AMIZADE {de:'renato@email.com', dataInicio:'27/01/2022'}]->(roberto)
CREATE (roberto)-[:PROXIMA_AMIZADE {de:'renato@email.com', dataInicio:'25/06/2022'}]->(juliana);

// --- Thiago Ferreira
//     roberto(2021) → vinicius(2023)
MATCH (thiago:Usuario  {email:'thiago@email.com'})
MATCH (roberto:Usuario {email:'roberto@email.com'})
MATCH (vinicius:Usuario {email:'vinicius@email.com'})
CREATE (thiago)-[:PRIMEIRA_AMIZADE]->(roberto)
CREATE (roberto)-[:PROXIMA_AMIZADE {de:'thiago@email.com', dataInicio:'04/01/2023'}]->(vinicius);

// --- Larissa Matos
//     camila(2021) → isabela(2022)
MATCH (larissa:Usuario {email:'larissa@email.com'})
MATCH (camila:Usuario  {email:'camila@email.com'})
MATCH (isabela:Usuario {email:'isabela@email.com'})
CREATE (larissa)-[:PRIMEIRA_AMIZADE]->(camila)
CREATE (camila) -[:PROXIMA_AMIZADE {de:'larissa@email.com', dataInicio:'17/07/2022'}]->(isabela);


// =============================================================
// 4. QUERIES PARA AS LISTAS LIGADAS
// =============================================================

// -----------------------------------------------------------------
// QL1: Percorrer o feed completo de um usuário (lista de posts)
//      Retorna os posts em ordem cronológica de publicação
// -----------------------------------------------------------------

MATCH (u:Usuario {email:'ana@email.com'})-[:PRIMEIRO_POST]->(inicio:Post)
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(post:Post)
RETURN post.titulo AS Titulo, post.autor AS Autor
ORDER BY length(path) ASC;


// -----------------------------------------------------------------
// QL2: Obter o Nº post do feed de um usuário (ex: 2º post)
// -----------------------------------------------------------------

MATCH (u:Usuario {email:'mariana@email.com'})-[:PRIMEIRO_POST]->(inicio:Post)
MATCH (inicio)-[:PROXIMO_POST*1]->(segundoPost:Post)
RETURN segundoPost.titulo AS SegundoPost;


// -----------------------------------------------------------------
// QL3: Inserir novo post no FINAL do feed (manutenção da lista)
//      Ajusta o ponteiro :PostFinal e cria o novo elo PROXIMO_POST
//      Exemplo: adicionando um novo post para a Ana
// -----------------------------------------------------------------

MATCH (u:Usuario {email:'ana@email.com'})-[:PRIMEIRO_POST]->(inicio:Post)
MATCH (inicio)-[:PROXIMO_POST*0..]->(ultimo:Post:PostFinal)
MATCH (novoPost:Post {titulo:'Tocando violão depois de 2 anos'})
// Remove a label PostFinal do atual último
REMOVE ultimo:PostFinal
// Conecta o último ao novo e marca o novo como PostFinal
CREATE (ultimo)-[:PROXIMO_POST {ordem: 99}]->(novoPost)
SET novoPost:PostFinal
RETURN novoPost.titulo AS NovoUltimoPost;


// -----------------------------------------------------------------
// QL4: Percorrer o histórico de amizades de um usuário
// -----------------------------------------------------------------

MATCH (u:Usuario {email:'roberto@email.com'})-[:PRIMEIRA_AMIZADE]->(primeiro:Usuario)
MATCH path = (primeiro)-[:PROXIMA_AMIZADE*0..]->(amigo:Usuario)
WHERE ALL(r IN relationships(path) WHERE r.de = 'roberto@email.com')
RETURN amigo.nome            AS Amigo,
       amigo.dataNascimento  AS Nascimento,
       length(path) + 1      AS OrdemCronologica
ORDER BY OrdemCronologica ASC;


// -----------------------------------------------------------------
// QL5: Quem foi o amigo mais recente de cada usuário?
//      (último nó da lista ligada de amizades)
// -----------------------------------------------------------------

MATCH (u:Usuario)-[:PRIMEIRA_AMIZADE]->(primeiro:Usuario)
MATCH path = (primeiro)-[:PROXIMA_AMIZADE*0..]->(ultimo:Usuario)
WHERE ALL(r IN relationships(path) WHERE r.de = u.email)
  AND NOT (ultimo)-[:PROXIMA_AMIZADE {de: u.email}]->()
RETURN u.nome       AS Usuario,
       ultimo.nome  AS AmigoMaisRecente;


// -----------------------------------------------------------------
// QL6: Tamanho do feed de cada usuário (comprimento da lista)
// -----------------------------------------------------------------

MATCH (u:Usuario)-[:PRIMEIRO_POST]->(inicio:Post)
MATCH path = (inicio)-[:PROXIMO_POST*0..]->(fim:Post)
WHERE fim:PostFinal
WITH u, MIN(length(path)) + 1 AS TotalPosts
RETURN u.nome AS Usuario, TotalPosts
ORDER BY TotalPosts DESC;
