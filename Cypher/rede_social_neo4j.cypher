// =============================================================
// REDE SOCIAL - ESTRUTURA COMPLETA PARA NEO4J AURA
// Gerado para importação direta via Neo4j Browser / Aura Console
// =============================================================

// -------------------------------------------------------------
// 0. CONSTRAINTS
// -------------------------------------------------------------
CREATE CONSTRAINT usuario_email_unique IF NOT EXISTS FOR (u:Usuario) REQUIRE u.email IS UNIQUE;
CREATE CONSTRAINT usuario_email_exists IF NOT EXISTS FOR (u:Usuario) REQUIRE u.email IS NOT NULL;
CREATE CONSTRAINT usuario_id_unique   IF NOT EXISTS FOR (u:Usuario) REQUIRE u.id    IS UNIQUE;


// =============================================================
// 1. USUÁRIOS (20 nós)
// =============================================================

CREATE (roberto:Usuario {
  id: 1042873,
  nome: 'Roberto Alves',
  email: 'roberto@email.com',
  dataCadastro: '14/03/2021',
  dataNascimento: '05/08/1988'
});

CREATE (ana:Usuario {
  id: 2938471,
  nome: 'Ana Schultz',
  email: 'ana@email.com',
  dataCadastro: '22/01/2020',
  dataNascimento: '17/03/1995'
});

CREATE (joao:Usuario {
  id: 3847291,
  nome: 'João Marins',
  email: 'joao@email.com',
  dataCadastro: '03/06/2019',
  dataNascimento: '29/11/1990'
});

CREATE (guilherme:Usuario {
  id: 4719283,
  nome: 'Guilherme Costa',
  email: 'guilherme@email.com',
  dataCadastro: '11/09/2022',
  dataNascimento: '14/07/1993'
});

CREATE (mariana:Usuario {
  id: 5038274,
  nome: 'Mariana Serena',
  email: 'mariana@email.com',
  dataCadastro: '30/04/2021',
  dataNascimento: '02/12/1997'
});

CREATE (carlos:Usuario {
  id: 6192847,
  nome: 'Carlos Eduardo',
  email: 'carlos@email.com',
  dataCadastro: '18/07/2020',
  dataNascimento: '23/06/1985'
});

CREATE (patricia:Usuario {
  id: 7384920,
  nome: 'Patrícia Lima',
  email: 'patricia@email.com',
  dataCadastro: '05/11/2018',
  dataNascimento: '09/01/1992'
});

CREATE (fernanda:Usuario {
  id: 8203947,
  nome: 'Fernanda Rocha',
  email: 'fernanda@email.com',
  dataCadastro: '27/02/2023',
  dataNascimento: '31/05/1999'
});

CREATE (lucas:Usuario {
  id: 9471023,
  nome: 'Lucas Mendes',
  email: 'lucas@email.com',
  dataCadastro: '14/08/2021',
  dataNascimento: '07/04/1996'
});

CREATE (beatriz:Usuario {
  id: 1029384,
  nome: 'Beatriz Nunes',
  email: 'beatriz@email.com',
  dataCadastro: '09/12/2019',
  dataNascimento: '18/10/1994'
});

CREATE (thiago:Usuario {
  id: 2837401,
  nome: 'Thiago Ferreira',
  email: 'thiago@email.com',
  dataCadastro: '21/03/2022',
  dataNascimento: '25/02/1989'
});

CREATE (camila:Usuario {
  id: 3910274,
  nome: 'Camila Borges',
  email: 'camila@email.com',
  dataCadastro: '16/06/2020',
  dataNascimento: '13/08/1998'
});

CREATE (rafael:Usuario {
  id: 4028371,
  nome: 'Rafael Souza',
  email: 'rafael@email.com',
  dataCadastro: '08/01/2023',
  dataNascimento: '04/09/2000'
});

CREATE (juliana:Usuario {
  id: 5193820,
  nome: 'Juliana Pinto',
  email: 'juliana@email.com',
  dataCadastro: '19/10/2021',
  dataNascimento: '11/07/1991'
});

CREATE (renato:Usuario {
  id: 6037192,
  nome: 'Renato Gomes',
  email: 'renato@email.com',
  dataNascimento: '28/03/1987',
  dataCadastro: '07/05/2019'
});

CREATE (isabela:Usuario {
  id: 7192038,
  nome: 'Isabela Vieira',
  email: 'isabela@email.com',
  dataCadastro: '23/09/2022',
  dataNascimento: '16/11/2001'
});

CREATE (diego:Usuario {
  id: 8304719,
  nome: 'Diego Carvalho',
  email: 'diego@email.com',
  dataCadastro: '12/07/2020',
  dataNascimento: '20/04/1993'
});

CREATE (larissa:Usuario {
  id: 9041738,
  nome: 'Larissa Matos',
  email: 'larissa@email.com',
  dataCadastro: '01/02/2021',
  dataNascimento: '06/06/1996'
});

CREATE (vinicius:Usuario {
  id: 1938402,
  nome: 'Vinícius Andrade',
  email: 'vinicius@email.com',
  dataCadastro: '28/11/2022',
  dataNascimento: '22/01/1990'
});

CREATE (helena:Usuario {
  id: 2071938,
  nome: 'Helena Faria',
  email: 'helena@email.com',
  dataCadastro: '15/04/2023',
  dataNascimento: '03/09/2003'
});


// =============================================================
// 2. COMUNIDADES
// =============================================================

CREATE (c1:Comunidade {
  nome: 'Galera do Rock',
  tema: 'Música',
  responsavel: 'Ana Schultz'
});

CREATE (c2:Comunidade {
  nome: 'Dev & Café',
  tema: 'Tecnologia',
  responsavel: 'Guilherme Costa'
});

CREATE (c3:Comunidade {
  nome: 'Pedalando pela Vida',
  tema: 'Ciclismo',
  responsavel: 'Carlos Eduardo'
});

CREATE (c4:Comunidade {
  nome: 'Foodies SP',
  tema: 'Gastronomia',
  responsavel: 'Mariana Serena'
});

CREATE (c5:Comunidade {
  nome: 'Investidores Jovens',
  tema: 'Finanças',
  responsavel: 'Roberto Alves'
});


// =============================================================
// 3. POSTS (50 nós)
// =============================================================

// --- Posts de Roberto (3) ---
CREATE (p1:Post { titulo: 'Como diversificar sua carteira em 2024', conteudo: 'Separei 5 dicas práticas para diversificar seus investimentos sem complicação.', autor: 'Roberto Alves' });
CREATE (p2:Post { titulo: 'Tesouro Direto vs CDB: qual escolher?', conteudo: 'Fiz uma comparação detalhada entre Tesouro Direto e CDB. Confira!', autor: 'Roberto Alves' });
CREATE (p3:Post { titulo: 'Meu primeiro aporte em FIIs', conteudo: 'Compartilhando minha experiência investindo em Fundos Imobiliários pela primeira vez.', autor: 'Roberto Alves' });

// --- Posts de Ana (4) ---
CREATE (p4:Post  { titulo: 'Top 10 álbuns de Rock dos anos 90', conteudo: 'Uma lista apaixonada pelos clássicos que definiram uma geração inteira.', autor: 'Ana Schultz' });
CREATE (p5:Post  { titulo: 'Show do Foo Fighters foi incrível!', conteudo: 'Acabei de chegar do show e ainda estou arrepiada. Simplesmente épico!', autor: 'Ana Schultz' });
CREATE (p6:Post  { titulo: 'Bandas independentes que você precisa conhecer', conteudo: 'Descobri três bandas incríveis esse mês e preciso compartilhar.', autor: 'Ana Schultz' });
CREATE (p7:Post  { titulo: 'Tocando violão depois de 2 anos', conteudo: 'Voltei a tocar violão e a sensação é de renascimento. Alguém mais passou por isso?', autor: 'Ana Schultz' });

// --- Posts de João (2) ---
CREATE (p8:Post  { titulo: 'Dica de trilha no Parque Estadual', conteudo: 'Fiz uma trilha linda no final de semana. Segue o roteiro completo!', autor: 'João Marins' });
CREATE (p9:Post  { titulo: 'Receita de nhoque da minha vó', conteudo: 'Tradição de domingo: nhoque da fortuna com o molho da vó. Receita no post!', autor: 'João Marins' });

// --- Posts de Guilherme (3) ---
CREATE (p10:Post { titulo: 'Por que aprendi TypeScript em 2024', conteudo: 'Tipagem estática mudou minha vida. Deixo aqui minha experiência após 6 meses.', autor: 'Guilherme Costa' });
CREATE (p11:Post { titulo: 'Docker do zero: guia prático', conteudo: 'Um guia rápido e direto para quem quer entender Docker de uma vez por todas.', autor: 'Guilherme Costa' });
CREATE (p12:Post { titulo: 'Meu setup de home office 2024', conteudo: 'Depois de muito teste, finalizei meu setup definitivo. Confira o que uso no dia a dia.', autor: 'Guilherme Costa' });

// --- Posts de Mariana (4) ---
CREATE (p13:Post { titulo: 'Restaurante novo em SP que vale muito', conteudo: 'Fui ao Oro ontem e saí apaixonada. Menu degustação impecável!', autor: 'Mariana Serena' });
CREATE (p14:Post { titulo: 'Receita: Risoto de cogumelos selvagens', conteudo: 'Simples, saboroso e perfeito para impressionar. Passo a passo aqui.', autor: 'Mariana Serena' });
CREATE (p15:Post { titulo: 'Vinhos naturais: vale a pena?', conteudo: 'Provei 5 rótulos e trouxe minha opinião honesta sobre vinhos naturais.', autor: 'Mariana Serena' });
CREATE (p16:Post { titulo: 'Mercado municipal: guia de compras', conteudo: 'Aprendi a comprar no Mercadão como chefe. Dicas de barganhas e produtos especiais.', autor: 'Mariana Serena' });

// --- Posts de Carlos (3) ---
CREATE (p17:Post { titulo: 'Pedalada até Embu das Artes', conteudo: '65km de pedal num domingo perfeito. Relato e fotos do percurso.', autor: 'Carlos Eduardo' });
CREATE (p18:Post { titulo: 'Manutenção básica da bike: aprenda você mesmo', conteudo: 'Calibrar pneu, ajustar freio e lubrificar corrente. Tudo que você precisa saber!', autor: 'Carlos Eduardo' });
CREATE (p19:Post { titulo: 'Rota nova: Serra da Cantareira de bike', conteudo: 'Encontrei uma rota nova pela Serra da Cantareira. Difícil mas recompensadora!', autor: 'Carlos Eduardo' });

// --- Posts de Patrícia (2) ---
CREATE (p20:Post { titulo: 'Yoga pela manhã transforma o dia', conteudo: 'Completei 30 dias de yoga matinal e minha produtividade disparou. Relato sincero.', autor: 'Patrícia Lima' });
CREATE (p21:Post { titulo: 'Livros de autoconhecimento que recomendo', conteudo: 'Três livros que mudaram minha forma de encarar desafios pessoais.', autor: 'Patrícia Lima' });

// --- Posts de Fernanda (3) ---
CREATE (p22:Post { titulo: 'Moda sustentável: onde comprar no Brasil', conteudo: 'Listei as melhores marcas nacionais que trabalham com moda consciente.', autor: 'Fernanda Rocha' });
CREATE (p23:Post { titulo: 'Thrift shopping em SP: guia completo', conteudo: 'Os melhores brechós da cidade e como achar peças únicas por menos de R$50.', autor: 'Fernanda Rocha' });
CREATE (p24:Post { titulo: 'Minimalismo no guarda-roupa', conteudo: 'Reduzi meu guarda-roupa de 80 para 30 peças e nunca fui tão feliz.', autor: 'Fernanda Rocha' });

// --- Posts de Lucas (2) ---
CREATE (p25:Post { titulo: 'Corrida de rua: minha primeira meia maratona', conteudo: 'Completei 21km! Relato emocionante de quem era sedentário há 2 anos.', autor: 'Lucas Mendes' });
CREATE (p26:Post { titulo: 'Suplementação para corredores iniciantes', conteudo: 'O que tomar, quando tomar e o que realmente faz diferença na performance.', autor: 'Lucas Mendes' });

// --- Posts de Beatriz (3) ---
CREATE (p27:Post { titulo: 'Design thinking na prática', conteudo: 'Apliquei design thinking num projeto real e trouxe o passo a passo aqui.', autor: 'Beatriz Nunes' });
CREATE (p28:Post { titulo: 'Portfólio de UX: o que não pode faltar', conteudo: 'Revisei 20 portfólios e listei os erros mais comuns. Confira se o seu está livre deles.', autor: 'Beatriz Nunes' });
CREATE (p29:Post { titulo: 'Figma tips que economizam horas', conteudo: 'Atalhos e plugins do Figma que uso todo dia e que mudaram minha produtividade.', autor: 'Beatriz Nunes' });

// --- Posts de Thiago (2) ---
CREATE (p30:Post { titulo: 'Investindo em cripto com responsabilidade', conteudo: 'Não coloque mais do que pode perder. Um guia de entrada consciente no mercado cripto.', autor: 'Thiago Ferreira' });
CREATE (p31:Post { titulo: 'Bitcoin em 2024: perspectivas realistas', conteudo: 'Análise técnica e fundamentalista do BTC para os próximos meses.', autor: 'Thiago Ferreira' });

// --- Posts de Camila (3) ---
CREATE (p32:Post { titulo: 'Intercâmbio em Lisboa: vale cada centavo', conteudo: 'Fui para Portugal com R$15mil e fiquei 3 meses. Veja como me virei!', autor: 'Camila Borges' });
CREATE (p33:Post { titulo: 'Aprender inglês sozinho em 2024', conteudo: 'Método que usei para chegar ao C1 sem pagar cursinho. Tudo gratuito.', autor: 'Camila Borges' });
CREATE (p34:Post { titulo: 'Viajar barato pela Europa: roteiro real', conteudo: 'Meu roteiro de 15 dias pela Europa com orçamento de mochileiro.', autor: 'Camila Borges' });

// --- Posts de Rafael (1) ---
CREATE (p35:Post { titulo: 'Primeiro emprego como dev: o que ninguém te conta', conteudo: 'Passei por 8 entrevistas antes de ser contratado. Aprendi muito e quero dividir.', autor: 'Rafael Souza' });

// --- Posts de Juliana (2) ---
CREATE (p36:Post { titulo: 'Marketing digital para pequenos negócios', conteudo: 'Como usei Instagram e WhatsApp para triplicar as vendas do meu ateliê.', autor: 'Juliana Pinto' });
CREATE (p37:Post { titulo: 'Criando conteúdo autêntico no Instagram', conteudo: 'Cheguei a 10k seguidores sendo eu mesma. Sem fórmula mágica, só consistência.', autor: 'Juliana Pinto' });

// --- Posts de Renato (3) ---
CREATE (p38:Post { titulo: 'Empreendedorismo após os 30: é possível', conteudo: 'Abri meu primeiro negócio aos 33 e aqui está tudo que aprendi no primeiro ano.', autor: 'Renato Gomes' });
CREATE (p39:Post { titulo: 'Gestão financeira para MEI', conteudo: 'Separo pessoal de empresarial faz 2 anos. Veja como organizo minhas finanças.', autor: 'Renato Gomes' });
CREATE (p40:Post { titulo: 'Networking que funciona de verdade', conteudo: 'Pare de entregar cartões e comece a criar conexões genuínas. Minha abordagem.', autor: 'Renato Gomes' });

// --- Posts de Isabela (2) ---
CREATE (p41:Post { titulo: 'Ansiedade na faculdade: como sobrevivi', conteudo: 'Relato honesto de quem quase desistiu no 2o semestre e encontrou equilíbrio.', autor: 'Isabela Vieira' });
CREATE (p42:Post { titulo: 'Redes sociais e saúde mental', conteudo: 'Fiz um detox digital de 30 dias e os resultados me surpreenderam.', autor: 'Isabela Vieira' });

// --- Posts de Diego (3) ---
CREATE (p43:Post { titulo: 'Futebol de várzea: a verdadeira escola', conteudo: 'Jogo bola todo sábado de manhã há 7 anos. É o melhor terapia que conheço.', autor: 'Diego Carvalho' });
CREATE (p44:Post { titulo: 'Como montar uma academia em casa gastando pouco', conteudo: 'Gastei R$800 e criei um espaço funcional de treino. Veja o que comprei.', autor: 'Diego Carvalho' });
CREATE (p45:Post { titulo: 'Treino de força para iniciantes: semana 1', conteudo: 'Programa completo de musculação para quem está começando do zero.', autor: 'Diego Carvalho' });

// --- Posts de Larissa (2) ---
CREATE (p46:Post { titulo: 'Como estudar para concurso público trabalhando', conteudo: 'Passei no concurso estudando 2h por dia. Método e rotina que funcionou.', autor: 'Larissa Matos' });
CREATE (p47:Post { titulo: 'Preparação para o ENEM depois dos 25', conteudo: 'Voltei a estudar para o ENEM aos 27. Relato e estratégia de quem passou.', autor: 'Larissa Matos' });

// --- Posts de Vinícius (2) ---
CREATE (p48:Post { titulo: 'Criando meu primeiro app com React Native', conteudo: 'Do zero ao deploy em 30 dias. Tudo que aprendi e os erros que cometi.', autor: 'Vinícius Andrade' });
CREATE (p49:Post { titulo: 'Open source: por que você deveria contribuir', conteudo: 'Contribuí para 3 projetos open source esse ano. Veja o impacto na minha carreira.', autor: 'Vinícius Andrade' });

// --- Posts de Helena (1) ---
CREATE (p50:Post { titulo: 'Dançar ballet aos 20 anos: nunca é tarde', conteudo: 'Comecei ballet adulto e foi a melhor decisão da minha vida. Veja minha jornada.', autor: 'Helena Faria' });


// =============================================================
// 4. RELACIONAMENTOS DE AMIZADE (E_AMIGO_DE)
// =============================================================

MATCH (roberto:Usuario {email:'roberto@email.com'}), (ana:Usuario {email:'ana@email.com'})
CREATE (roberto)-[:E_AMIGO_DE {dataInicio: '12/07/2020 10h30\'00\'\''}]->(ana),
       (ana)-[:E_AMIGO_DE {dataInicio: '12/07/2020 10h30\'00\'\''}]->(roberto);

MATCH (roberto:Usuario {email:'roberto@email.com'}), (joao:Usuario {email:'joao@email.com'})
CREATE (roberto)-[:E_AMIGO_DE {dataInicio: '03/03/2021 14h45\'12\'\''}]->(joao),
       (joao)-[:E_AMIGO_DE {dataInicio: '03/03/2021 14h45\'12\'\''}]->(roberto);

MATCH (roberto:Usuario {email:'roberto@email.com'}), (thiago:Usuario {email:'thiago@email.com'})
CREATE (roberto)-[:E_AMIGO_DE {dataInicio: '19/08/2021 09h00\'00\'\''}]->(thiago),
       (thiago)-[:E_AMIGO_DE {dataInicio: '19/08/2021 09h00\'00\'\''}]->(roberto);

MATCH (roberto:Usuario {email:'roberto@email.com'}), (renato:Usuario {email:'renato@email.com'})
CREATE (roberto)-[:E_AMIGO_DE {dataInicio: '27/01/2022 11h20\'05\'\''}]->(renato),
       (renato)-[:E_AMIGO_DE {dataInicio: '27/01/2022 11h20\'05\'\''}]->(roberto);

MATCH (joao:Usuario {email:'joao@email.com'}), (guilherme:Usuario {email:'guilherme@email.com'})
CREATE (joao)-[:E_AMIGO_DE {dataInicio: '15/04/2019 16h00\'00\'\''}]->(guilherme),
       (guilherme)-[:E_AMIGO_DE {dataInicio: '15/04/2019 16h00\'00\'\''}]->(joao);

MATCH (joao:Usuario {email:'joao@email.com'}), (beatriz:Usuario {email:'beatriz@email.com'})
CREATE (joao)-[:E_AMIGO_DE {dataInicio: '08/12/2019 18h30\'22\'\''}]->(beatriz),
       (beatriz)-[:E_AMIGO_DE {dataInicio: '08/12/2019 18h30\'22\'\''}]->(joao);

MATCH (guilherme:Usuario {email:'guilherme@email.com'}), (lucas:Usuario {email:'lucas@email.com'})
CREATE (guilherme)-[:E_AMIGO_DE {dataInicio: '22/10/2022 08h15\'00\'\''}]->(lucas),
       (lucas)-[:E_AMIGO_DE {dataInicio: '22/10/2022 08h15\'00\'\''}]->(guilherme);

MATCH (guilherme:Usuario {email:'guilherme@email.com'}), (vinicius:Usuario {email:'vinicius@email.com'})
CREATE (guilherme)-[:E_AMIGO_DE {dataInicio: '05/12/2022 20h00\'00\'\''}]->(vinicius),
       (vinicius)-[:E_AMIGO_DE {dataInicio: '05/12/2022 20h00\'00\'\''}]->(guilherme);

MATCH (guilherme:Usuario {email:'guilherme@email.com'}), (rafael:Usuario {email:'rafael@email.com'})
CREATE (guilherme)-[:E_AMIGO_DE {dataInicio: '14/02/2023 13h10\'45\'\''}]->(rafael),
       (rafael)-[:E_AMIGO_DE {dataInicio: '14/02/2023 13h10\'45\'\''}]->(guilherme);

MATCH (ana:Usuario {email:'ana@email.com'}), (mariana:Usuario {email:'mariana@email.com'})
CREATE (ana)-[:E_AMIGO_DE {dataInicio: '30/06/2021 17h55\'30\'\''}]->(mariana),
       (mariana)-[:E_AMIGO_DE {dataInicio: '30/06/2021 17h55\'30\'\''}]->(ana);

MATCH (ana:Usuario {email:'ana@email.com'}), (camila:Usuario {email:'camila@email.com'})
CREATE (ana)-[:E_AMIGO_DE {dataInicio: '11/11/2020 09h30\'00\'\''}]->(camila),
       (camila)-[:E_AMIGO_DE {dataInicio: '11/11/2020 09h30\'00\'\''}]->(ana);

MATCH (mariana:Usuario {email:'mariana@email.com'}), (juliana:Usuario {email:'juliana@email.com'})
CREATE (mariana)-[:E_AMIGO_DE {dataInicio: '07/09/2021 12h00\'00\'\''}]->(juliana),
       (juliana)-[:E_AMIGO_DE {dataInicio: '07/09/2021 12h00\'00\'\''}]->(mariana);

MATCH (carlos:Usuario {email:'carlos@email.com'}), (lucas:Usuario {email:'lucas@email.com'})
CREATE (carlos)-[:E_AMIGO_DE {dataInicio: '01/01/2022 07h00\'00\'\''}]->(lucas),
       (lucas)-[:E_AMIGO_DE {dataInicio: '01/01/2022 07h00\'00\'\''}]->(carlos);

MATCH (carlos:Usuario {email:'carlos@email.com'}), (diego:Usuario {email:'diego@email.com'})
CREATE (carlos)-[:E_AMIGO_DE {dataInicio: '18/05/2020 15h40\'00\'\''}]->(diego),
       (diego)-[:E_AMIGO_DE {dataInicio: '18/05/2020 15h40\'00\'\''}]->(carlos);

MATCH (patricia:Usuario {email:'patricia@email.com'}), (isabela:Usuario {email:'isabela@email.com'})
CREATE (patricia)-[:E_AMIGO_DE {dataInicio: '03/10/2022 11h00\'00\'\''}]->(isabela),
       (isabela)-[:E_AMIGO_DE {dataInicio: '03/10/2022 11h00\'00\'\''}]->(patricia);

MATCH (patricia:Usuario {email:'patricia@email.com'}), (helena:Usuario {email:'helena@email.com'})
CREATE (patricia)-[:E_AMIGO_DE {dataInicio: '29/05/2023 14h20\'33\'\''}]->(helena),
       (helena)-[:E_AMIGO_DE {dataInicio: '29/05/2023 14h20\'33\'\''}]->(patricia);

MATCH (fernanda:Usuario {email:'fernanda@email.com'}), (camila:Usuario {email:'camila@email.com'})
CREATE (fernanda)-[:E_AMIGO_DE {dataInicio: '20/03/2023 10h50\'00\'\''}]->(camila),
       (camila)-[:E_AMIGO_DE {dataInicio: '20/03/2023 10h50\'00\'\''}]->(fernanda);

MATCH (beatriz:Usuario {email:'beatriz@email.com'}), (juliana:Usuario {email:'juliana@email.com'})
CREATE (beatriz)-[:E_AMIGO_DE {dataInicio: '12/08/2020 19h15\'00\'\''}]->(juliana),
       (juliana)-[:E_AMIGO_DE {dataInicio: '12/08/2020 19h15\'00\'\''}]->(beatriz);

MATCH (thiago:Usuario {email:'thiago@email.com'}), (vinicius:Usuario {email:'vinicius@email.com'})
CREATE (thiago)-[:E_AMIGO_DE {dataInicio: '04/01/2023 08h00\'00\'\''}]->(vinicius),
       (vinicius)-[:E_AMIGO_DE {dataInicio: '04/01/2023 08h00\'00\'\''}]->(thiago);

MATCH (renato:Usuario {email:'renato@email.com'}), (juliana:Usuario {email:'juliana@email.com'})
CREATE (renato)-[:E_AMIGO_DE {dataInicio: '25/06/2022 16h30\'00\'\''}]->(juliana),
       (juliana)-[:E_AMIGO_DE {dataInicio: '25/06/2022 16h30\'00\'\''}]->(renato);

MATCH (renato:Usuario {email:'renato@email.com'}), (diego:Usuario {email:'diego@email.com'})
CREATE (renato)-[:E_AMIGO_DE {dataInicio: '09/09/2021 10h10\'10\'\''}]->(diego),
       (diego)-[:E_AMIGO_DE {dataInicio: '09/09/2021 10h10\'10\'\''}]->(renato);

MATCH (larissa:Usuario {email:'larissa@email.com'}), (isabela:Usuario {email:'isabela@email.com'})
CREATE (larissa)-[:E_AMIGO_DE {dataInicio: '17/07/2022 13h00\'00\'\''}]->(isabela),
       (isabela)-[:E_AMIGO_DE {dataInicio: '17/07/2022 13h00\'00\'\''}]->(larissa);

MATCH (larissa:Usuario {email:'larissa@email.com'}), (camila:Usuario {email:'camila@email.com'})
CREATE (larissa)-[:E_AMIGO_DE {dataInicio: '28/02/2021 09h45\'00\'\''}]->(camila),
       (camila)-[:E_AMIGO_DE {dataInicio: '28/02/2021 09h45\'00\'\''}]->(larissa);

MATCH (rafael:Usuario {email:'rafael@email.com'}), (vinicius:Usuario {email:'vinicius@email.com'})
CREATE (rafael)-[:E_AMIGO_DE {dataInicio: '10/01/2023 22h00\'00\'\''}]->(vinicius),
       (vinicius)-[:E_AMIGO_DE {dataInicio: '10/01/2023 22h00\'00\'\''}]->(rafael);

MATCH (helena:Usuario {email:'helena@email.com'}), (fernanda:Usuario {email:'fernanda@email.com'})
CREATE (helena)-[:E_AMIGO_DE {dataInicio: '02/06/2023 15h30\'00\'\''}]->(fernanda),
       (fernanda)-[:E_AMIGO_DE {dataInicio: '02/06/2023 15h30\'00\'\''}]->(helena);


// =============================================================
// 5. RELACIONAMENTOS USUÁRIO -[POSTOU]-> POST
// =============================================================

MATCH (u:Usuario {email:'roberto@email.com'}), (p:Post {titulo:'Como diversificar sua carteira em 2024'})
CREATE (u)-[:POSTOU {dataPostagem: '10/01/2024 08h30\'00\'\''}]->(p);
MATCH (u:Usuario {email:'roberto@email.com'}), (p:Post {titulo:'Tesouro Direto vs CDB: qual escolher?'})
CREATE (u)-[:POSTOU {dataPostagem: '22/02/2024 09h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'roberto@email.com'}), (p:Post {titulo:'Meu primeiro aporte em FIIs'})
CREATE (u)-[:POSTOU {dataPostagem: '05/03/2024 10h15\'00\'\''}]->(p);

MATCH (u:Usuario {email:'ana@email.com'}), (p:Post {titulo:'Top 10 álbuns de Rock dos anos 90'})
CREATE (u)-[:POSTOU {dataPostagem: '14/01/2024 19h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'ana@email.com'}), (p:Post {titulo:'Show do Foo Fighters foi incrível!'})
CREATE (u)-[:POSTOU {dataPostagem: '18/02/2024 23h45\'00\'\''}]->(p);
MATCH (u:Usuario {email:'ana@email.com'}), (p:Post {titulo:'Bandas independentes que você precisa conhecer'})
CREATE (u)-[:POSTOU {dataPostagem: '01/03/2024 20h30\'00\'\''}]->(p);
MATCH (u:Usuario {email:'ana@email.com'}), (p:Post {titulo:'Tocando violão depois de 2 anos'})
CREATE (u)-[:POSTOU {dataPostagem: '12/03/2024 21h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'joao@email.com'}), (p:Post {titulo:'Dica de trilha no Parque Estadual'})
CREATE (u)-[:POSTOU {dataPostagem: '20/01/2024 07h30\'00\'\''}]->(p);
MATCH (u:Usuario {email:'joao@email.com'}), (p:Post {titulo:'Receita de nhoque da minha vó'})
CREATE (u)-[:POSTOU {dataPostagem: '04/02/2024 12h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'guilherme@email.com'}), (p:Post {titulo:'Por que aprendi TypeScript em 2024'})
CREATE (u)-[:POSTOU {dataPostagem: '08/01/2024 10h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'guilherme@email.com'}), (p:Post {titulo:'Docker do zero: guia prático'})
CREATE (u)-[:POSTOU {dataPostagem: '15/02/2024 11h30\'00\'\''}]->(p);
MATCH (u:Usuario {email:'guilherme@email.com'}), (p:Post {titulo:'Meu setup de home office 2024'})
CREATE (u)-[:POSTOU {dataPostagem: '28/02/2024 18h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'mariana@email.com'}), (p:Post {titulo:'Restaurante novo em SP que vale muito'})
CREATE (u)-[:POSTOU {dataPostagem: '11/01/2024 14h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'mariana@email.com'}), (p:Post {titulo:'Receita: Risoto de cogumelos selvagens'})
CREATE (u)-[:POSTOU {dataPostagem: '25/01/2024 19h30\'00\'\''}]->(p);
MATCH (u:Usuario {email:'mariana@email.com'}), (p:Post {titulo:'Vinhos naturais: vale a pena?'})
CREATE (u)-[:POSTOU {dataPostagem: '09/02/2024 20h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'mariana@email.com'}), (p:Post {titulo:'Mercado municipal: guia de compras'})
CREATE (u)-[:POSTOU {dataPostagem: '01/03/2024 09h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'carlos@email.com'}), (p:Post {titulo:'Pedalada até Embu das Artes'})
CREATE (u)-[:POSTOU {dataPostagem: '17/01/2024 16h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'carlos@email.com'}), (p:Post {titulo:'Manutenção básica da bike: aprenda você mesmo'})
CREATE (u)-[:POSTOU {dataPostagem: '05/02/2024 10h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'carlos@email.com'}), (p:Post {titulo:'Rota nova: Serra da Cantareira de bike'})
CREATE (u)-[:POSTOU {dataPostagem: '20/02/2024 07h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'patricia@email.com'}), (p:Post {titulo:'Yoga pela manhã transforma o dia'})
CREATE (u)-[:POSTOU {dataPostagem: '03/01/2024 06h30\'00\'\''}]->(p);
MATCH (u:Usuario {email:'patricia@email.com'}), (p:Post {titulo:'Livros de autoconhecimento que recomendo'})
CREATE (u)-[:POSTOU {dataPostagem: '14/02/2024 08h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'fernanda@email.com'}), (p:Post {titulo:'Moda sustentável: onde comprar no Brasil'})
CREATE (u)-[:POSTOU {dataPostagem: '16/01/2024 13h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'fernanda@email.com'}), (p:Post {titulo:'Thrift shopping em SP: guia completo'})
CREATE (u)-[:POSTOU {dataPostagem: '27/02/2024 15h30\'00\'\''}]->(p);
MATCH (u:Usuario {email:'fernanda@email.com'}), (p:Post {titulo:'Minimalismo no guarda-roupa'})
CREATE (u)-[:POSTOU {dataPostagem: '08/03/2024 11h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'lucas@email.com'}), (p:Post {titulo:'Corrida de rua: minha primeira meia maratona'})
CREATE (u)-[:POSTOU {dataPostagem: '21/01/2024 17h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'lucas@email.com'}), (p:Post {titulo:'Suplementação para corredores iniciantes'})
CREATE (u)-[:POSTOU {dataPostagem: '10/02/2024 09h30\'00\'\''}]->(p);

MATCH (u:Usuario {email:'beatriz@email.com'}), (p:Post {titulo:'Design thinking na prática'})
CREATE (u)-[:POSTOU {dataPostagem: '06/01/2024 10h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'beatriz@email.com'}), (p:Post {titulo:'Portfólio de UX: o que não pode faltar'})
CREATE (u)-[:POSTOU {dataPostagem: '19/02/2024 14h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'beatriz@email.com'}), (p:Post {titulo:'Figma tips que economizam horas'})
CREATE (u)-[:POSTOU {dataPostagem: '07/03/2024 16h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'thiago@email.com'}), (p:Post {titulo:'Investindo em cripto com responsabilidade'})
CREATE (u)-[:POSTOU {dataPostagem: '13/01/2024 20h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'thiago@email.com'}), (p:Post {titulo:'Bitcoin em 2024: perspectivas realistas'})
CREATE (u)-[:POSTOU {dataPostagem: '24/02/2024 21h30\'00\'\''}]->(p);

MATCH (u:Usuario {email:'camila@email.com'}), (p:Post {titulo:'Intercâmbio em Lisboa: vale cada centavo'})
CREATE (u)-[:POSTOU {dataPostagem: '09/01/2024 18h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'camila@email.com'}), (p:Post {titulo:'Aprender inglês sozinho em 2024'})
CREATE (u)-[:POSTOU {dataPostagem: '23/01/2024 10h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'camila@email.com'}), (p:Post {titulo:'Viajar barato pela Europa: roteiro real'})
CREATE (u)-[:POSTOU {dataPostagem: '15/02/2024 12h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'rafael@email.com'}), (p:Post {titulo:'Primeiro emprego como dev: o que ninguém te conta'})
CREATE (u)-[:POSTOU {dataPostagem: '11/01/2024 09h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'juliana@email.com'}), (p:Post {titulo:'Marketing digital para pequenos negócios'})
CREATE (u)-[:POSTOU {dataPostagem: '07/01/2024 11h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'juliana@email.com'}), (p:Post {titulo:'Criando conteúdo autêntico no Instagram'})
CREATE (u)-[:POSTOU {dataPostagem: '20/02/2024 17h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'renato@email.com'}), (p:Post {titulo:'Empreendedorismo após os 30: é possível'})
CREATE (u)-[:POSTOU {dataPostagem: '04/01/2024 08h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'renato@email.com'}), (p:Post {titulo:'Gestão financeira para MEI'})
CREATE (u)-[:POSTOU {dataPostagem: '18/01/2024 09h30\'00\'\''}]->(p);
MATCH (u:Usuario {email:'renato@email.com'}), (p:Post {titulo:'Networking que funciona de verdade'})
CREATE (u)-[:POSTOU {dataPostagem: '06/03/2024 10h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'isabela@email.com'}), (p:Post {titulo:'Ansiedade na faculdade: como sobrevivi'})
CREATE (u)-[:POSTOU {dataPostagem: '05/01/2024 22h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'isabela@email.com'}), (p:Post {titulo:'Redes sociais e saúde mental'})
CREATE (u)-[:POSTOU {dataPostagem: '28/02/2024 20h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'diego@email.com'}), (p:Post {titulo:'Futebol de várzea: a verdadeira escola'})
CREATE (u)-[:POSTOU {dataPostagem: '13/01/2024 07h30\'00\'\''}]->(p);
MATCH (u:Usuario {email:'diego@email.com'}), (p:Post {titulo:'Como montar uma academia em casa gastando pouco'})
CREATE (u)-[:POSTOU {dataPostagem: '26/01/2024 14h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'diego@email.com'}), (p:Post {titulo:'Treino de força para iniciantes: semana 1'})
CREATE (u)-[:POSTOU {dataPostagem: '09/02/2024 15h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'larissa@email.com'}), (p:Post {titulo:'Como estudar para concurso público trabalhando'})
CREATE (u)-[:POSTOU {dataPostagem: '02/01/2024 07h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'larissa@email.com'}), (p:Post {titulo:'Preparação para o ENEM depois dos 25'})
CREATE (u)-[:POSTOU {dataPostagem: '16/02/2024 08h00\'00\'\''}]->(p);

MATCH (u:Usuario {email:'vinicius@email.com'}), (p:Post {titulo:'Criando meu primeiro app com React Native'})
CREATE (u)-[:POSTOU {dataPostagem: '30/01/2024 19h00\'00\'\''}]->(p);
MATCH (u:Usuario {email:'vinicius@email.com'}), (p:Post {titulo:'Open source: por que você deveria contribuir'})
CREATE (u)-[:POSTOU {dataPostagem: '12/02/2024 20h30\'00\'\''}]->(p);

MATCH (u:Usuario {email:'helena@email.com'}), (p:Post {titulo:'Dançar ballet aos 20 anos: nunca é tarde'})
CREATE (u)-[:POSTOU {dataPostagem: '03/03/2024 21h00\'00\'\''}]->(p);


// =============================================================
// 6. NÓS DE AÇÃO (Curtir / Comentar / Compartilhar)
//    Label: Acao
//    Relações:
//    Usuario -[CURTIU_O_POST / COMENTOU_O_POST / COMPARTILHOU_O_POST]-> Acao
//    Acao -[PERTENCE_AO_POST]-> Post
// =============================================================

// --- Curtidas ---
MATCH (u:Usuario {email:'joao@email.com'}), (p:Post {titulo:'Como diversificar sua carteira em 2024'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'10/01/2024 09h05\'22\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'thiago@email.com'}), (p:Post {titulo:'Como diversificar sua carteira em 2024'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'10/01/2024 10h12\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'ana@email.com'}), (p:Post {titulo:'Tesouro Direto vs CDB: qual escolher?'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'22/02/2024 09h30\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'mariana@email.com'}), (p:Post {titulo:'Top 10 álbuns de Rock dos anos 90'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'14/01/2024 20h00\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'camila@email.com'}), (p:Post {titulo:'Top 10 álbuns de Rock dos anos 90'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'14/01/2024 21h10\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'lucas@email.com'}), (p:Post {titulo:'Docker do zero: guia prático'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'15/02/2024 12h00\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'rafael@email.com'}), (p:Post {titulo:'Docker do zero: guia prático'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'15/02/2024 14h00\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'beatriz@email.com'}), (p:Post {titulo:'Restaurante novo em SP que vale muito'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'11/01/2024 15h00\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'juliana@email.com'}), (p:Post {titulo:'Restaurante novo em SP que vale muito'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'11/01/2024 16h30\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'carlos@email.com'}), (p:Post {titulo:'Corrida de rua: minha primeira meia maratona'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'21/01/2024 18h00\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'diego@email.com'}), (p:Post {titulo:'Corrida de rua: minha primeira meia maratona'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'21/01/2024 19h15\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'roberto@email.com'}), (p:Post {titulo:'Networking que funciona de verdade'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'06/03/2024 11h00\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'renato@email.com'}), (p:Post {titulo:'Bitcoin em 2024: perspectivas realistas'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'24/02/2024 22h00\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'isabela@email.com'}), (p:Post {titulo:'Ansiedade na faculdade: como sobrevivi'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'05/01/2024 23h00\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'patricia@email.com'}), (p:Post {titulo:'Ansiedade na faculdade: como sobrevivi'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'06/01/2024 08h30\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'helena@email.com'}), (p:Post {titulo:'Dançar ballet aos 20 anos: nunca é tarde'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'03/03/2024 22h00\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'fernanda@email.com'}), (p:Post {titulo:'Dançar ballet aos 20 anos: nunca é tarde'})
CREATE (a:Acao:Curtida {tipo:'Curtida', dataHora:'04/03/2024 09h00\'00\'\''})
CREATE (u)-[:CURTIU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

// --- Comentários ---
MATCH (u:Usuario {email:'joao@email.com'}), (p:Post {titulo:'Como diversificar sua carteira em 2024'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Excelente post! Já aplico algumas dessas dicas.', dataHora:'10/01/2024 09h20\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'ana@email.com'}), (p:Post {titulo:'Como diversificar sua carteira em 2024'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Roberto, você sempre traz ótimas dicas! Obrigada.', dataHora:'10/01/2024 11h00\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'guilherme@email.com'}), (p:Post {titulo:'Por que aprendi TypeScript em 2024'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'TypeScript mudou minha vida também! Ótimo post.', dataHora:'08/01/2024 11h00\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'vinicius@email.com'}), (p:Post {titulo:'Por que aprendi TypeScript em 2024'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Estava pensando em aprender, esse post me convenceu!', dataHora:'08/01/2024 15h30\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'mariana@email.com'}), (p:Post {titulo:'Top 10 álbuns de Rock dos anos 90'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Nevermind precisa estar no topo! Clássico eterno.', dataHora:'14/01/2024 20h30\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'carlos@email.com'}), (p:Post {titulo:'Pedalada até Embu das Artes'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Que pedalada incrível! Preciso fazer esse percurso.', dataHora:'17/01/2024 17h00\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'lucas@email.com'}), (p:Post {titulo:'Pedalada até Embu das Artes'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Fiz esse percurso no mês passado, vale muito!', dataHora:'17/01/2024 18h10\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'beatriz@email.com'}), (p:Post {titulo:'Design thinking na prática'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Poderia compartilhar o template que usou?', dataHora:'06/01/2024 11h30\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'isabela@email.com'}), (p:Post {titulo:'Redes sociais e saúde mental'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Passei pela mesma coisa. O detox foi libertador.', dataHora:'28/02/2024 21h00\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'patricia@email.com'}), (p:Post {titulo:'Redes sociais e saúde mental'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Muito importante esse tema. Parabéns pelo relato honesto.', dataHora:'01/03/2024 07h00\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'renato@email.com'}), (p:Post {titulo:'Empreendedorismo após os 30: é possível'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Me identifico muito! Abri meu negócio aos 34.', dataHora:'04/01/2024 09h00\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'thiago@email.com'}), (p:Post {titulo:'Bitcoin em 2024: perspectivas realistas'})
CREATE (a:Acao:Comentario {tipo:'Comentario', texto:'Análise muito equilibrada. Compartilhando!', dataHora:'24/02/2024 22h30\'00\'\''})
CREATE (u)-[:COMENTOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

// --- Compartilhamentos ---
MATCH (u:Usuario {email:'guilherme@email.com'}), (p:Post {titulo:'Como diversificar sua carteira em 2024'})
CREATE (a:Acao:Compartilhamento {tipo:'Compartilhamento', dataHora:'10/01/2024 12h00\'00\'\''})
CREATE (u)-[:COMPARTILHOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'renato@email.com'}), (p:Post {titulo:'Como diversificar sua carteira em 2024'})
CREATE (a:Acao:Compartilhamento {tipo:'Compartilhamento', dataHora:'11/01/2024 08h00\'00\'\''})
CREATE (u)-[:COMPARTILHOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'camila@email.com'}), (p:Post {titulo:'Top 10 álbuns de Rock dos anos 90'})
CREATE (a:Acao:Compartilhamento {tipo:'Compartilhamento', dataHora:'15/01/2024 10h00\'00\'\''})
CREATE (u)-[:COMPARTILHOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'vinicius@email.com'}), (p:Post {titulo:'Docker do zero: guia prático'})
CREATE (a:Acao:Compartilhamento {tipo:'Compartilhamento', dataHora:'16/02/2024 09h00\'00\'\''})
CREATE (u)-[:COMPARTILHOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'rafael@email.com'}), (p:Post {titulo:'Por que aprendi TypeScript em 2024'})
CREATE (a:Acao:Compartilhamento {tipo:'Compartilhamento', dataHora:'09/01/2024 10h00\'00\'\''})
CREATE (u)-[:COMPARTILHOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'joao@email.com'}), (p:Post {titulo:'Pedalada até Embu das Artes'})
CREATE (a:Acao:Compartilhamento {tipo:'Compartilhamento', dataHora:'17/01/2024 20h00\'00\'\''})
CREATE (u)-[:COMPARTILHOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'larissa@email.com'}), (p:Post {titulo:'Como estudar para concurso público trabalhando'})
CREATE (a:Acao:Compartilhamento {tipo:'Compartilhamento', dataHora:'02/01/2024 08h30\'00\'\''})
CREATE (u)-[:COMPARTILHOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'isabela@email.com'}), (p:Post {titulo:'Como estudar para concurso público trabalhando'})
CREATE (a:Acao:Compartilhamento {tipo:'Compartilhamento', dataHora:'03/01/2024 09h00\'00\'\''})
CREATE (u)-[:COMPARTILHOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'diego@email.com'}), (p:Post {titulo:'Treino de força para iniciantes: semana 1'})
CREATE (a:Acao:Compartilhamento {tipo:'Compartilhamento', dataHora:'09/02/2024 16h30\'00\'\''})
CREATE (u)-[:COMPARTILHOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);

MATCH (u:Usuario {email:'carlos@email.com'}), (p:Post {titulo:'Treino de força para iniciantes: semana 1'})
CREATE (a:Acao:Compartilhamento {tipo:'Compartilhamento', dataHora:'10/02/2024 07h00\'00\'\''})
CREATE (u)-[:COMPARTILHOU_O_POST]->(a)-[:PERTENCE_AO_POST]->(p);


// =============================================================
// 7. MEMBROS DAS COMUNIDADES
// =============================================================

// Comunidade: Galera do Rock
MATCH (u:Usuario {email:'ana@email.com'}), (c:Comunidade {nome:'Galera do Rock'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'mariana@email.com'}), (c:Comunidade {nome:'Galera do Rock'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'camila@email.com'}), (c:Comunidade {nome:'Galera do Rock'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'joao@email.com'}), (c:Comunidade {nome:'Galera do Rock'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'thiago@email.com'}), (c:Comunidade {nome:'Galera do Rock'})
CREATE (u)-[:PERTENCE_A]->(c);

// Comunidade: Dev & Café
MATCH (u:Usuario {email:'guilherme@email.com'}), (c:Comunidade {nome:'Dev & Café'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'vinicius@email.com'}), (c:Comunidade {nome:'Dev & Café'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'rafael@email.com'}), (c:Comunidade {nome:'Dev & Café'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'beatriz@email.com'}), (c:Comunidade {nome:'Dev & Café'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'lucas@email.com'}), (c:Comunidade {nome:'Dev & Café'})
CREATE (u)-[:PERTENCE_A]->(c);

// Comunidade: Pedalando pela Vida
MATCH (u:Usuario {email:'carlos@email.com'}), (c:Comunidade {nome:'Pedalando pela Vida'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'lucas@email.com'}), (c:Comunidade {nome:'Pedalando pela Vida'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'joao@email.com'}), (c:Comunidade {nome:'Pedalando pela Vida'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'diego@email.com'}), (c:Comunidade {nome:'Pedalando pela Vida'})
CREATE (u)-[:PERTENCE_A]->(c);

// Comunidade: Foodies SP
MATCH (u:Usuario {email:'mariana@email.com'}), (c:Comunidade {nome:'Foodies SP'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'juliana@email.com'}), (c:Comunidade {nome:'Foodies SP'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'beatriz@email.com'}), (c:Comunidade {nome:'Foodies SP'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'renato@email.com'}), (c:Comunidade {nome:'Foodies SP'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'ana@email.com'}), (c:Comunidade {nome:'Foodies SP'})
CREATE (u)-[:PERTENCE_A]->(c);

// Comunidade: Investidores Jovens
MATCH (u:Usuario {email:'roberto@email.com'}), (c:Comunidade {nome:'Investidores Jovens'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'thiago@email.com'}), (c:Comunidade {nome:'Investidores Jovens'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'renato@email.com'}), (c:Comunidade {nome:'Investidores Jovens'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'larissa@email.com'}), (c:Comunidade {nome:'Investidores Jovens'})
CREATE (u)-[:PERTENCE_A]->(c);
MATCH (u:Usuario {email:'guilherme@email.com'}), (c:Comunidade {nome:'Investidores Jovens'})
CREATE (u)-[:PERTENCE_A]->(c);


// =============================================================
// 8. POSTS PERTENCENTES A COMUNIDADES
// =============================================================

// Posts na Galera do Rock
MATCH (p:Post {titulo:'Top 10 álbuns de Rock dos anos 90'}), (c:Comunidade {nome:'Galera do Rock'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Show do Foo Fighters foi incrível!'}), (c:Comunidade {nome:'Galera do Rock'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Bandas independentes que você precisa conhecer'}), (c:Comunidade {nome:'Galera do Rock'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Tocando violão depois de 2 anos'}), (c:Comunidade {nome:'Galera do Rock'})
CREATE (p)-[:PERTENCE_A]->(c);

// Posts no Dev & Café
MATCH (p:Post {titulo:'Por que aprendi TypeScript em 2024'}), (c:Comunidade {nome:'Dev & Café'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Docker do zero: guia prático'}), (c:Comunidade {nome:'Dev & Café'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Criando meu primeiro app com React Native'}), (c:Comunidade {nome:'Dev & Café'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Open source: por que você deveria contribuir'}), (c:Comunidade {nome:'Dev & Café'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Figma tips que economizam horas'}), (c:Comunidade {nome:'Dev & Café'})
CREATE (p)-[:PERTENCE_A]->(c);

// Posts no Pedalando pela Vida
MATCH (p:Post {titulo:'Pedalada até Embu das Artes'}), (c:Comunidade {nome:'Pedalando pela Vida'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Manutenção básica da bike: aprenda você mesmo'}), (c:Comunidade {nome:'Pedalando pela Vida'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Rota nova: Serra da Cantareira de bike'}), (c:Comunidade {nome:'Pedalando pela Vida'})
CREATE (p)-[:PERTENCE_A]->(c);

// Posts no Foodies SP
MATCH (p:Post {titulo:'Restaurante novo em SP que vale muito'}), (c:Comunidade {nome:'Foodies SP'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Receita: Risoto de cogumelos selvagens'}), (c:Comunidade {nome:'Foodies SP'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Vinhos naturais: vale a pena?'}), (c:Comunidade {nome:'Foodies SP'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Mercado municipal: guia de compras'}), (c:Comunidade {nome:'Foodies SP'})
CREATE (p)-[:PERTENCE_A]->(c);

// Posts no Investidores Jovens
MATCH (p:Post {titulo:'Como diversificar sua carteira em 2024'}), (c:Comunidade {nome:'Investidores Jovens'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Tesouro Direto vs CDB: qual escolher?'}), (c:Comunidade {nome:'Investidores Jovens'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Meu primeiro aporte em FIIs'}), (c:Comunidade {nome:'Investidores Jovens'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Investindo em cripto com responsabilidade'}), (c:Comunidade {nome:'Investidores Jovens'})
CREATE (p)-[:PERTENCE_A]->(c);
MATCH (p:Post {titulo:'Bitcoin em 2024: perspectivas realistas'}), (c:Comunidade {nome:'Investidores Jovens'})
CREATE (p)-[:PERTENCE_A]->(c);


// =============================================================
// 9. QUERIES INTELIGENTES
// =============================================================

// -----------------------------------------------------------------
// Q1: QUERY DE MARKETING — mínimo de saltos até jovens (25–35 anos)
//     ligados ao Roberto
//     (Considera data de referência: 14/03/2026)
// -----------------------------------------------------------------
// Esta query usa shortestPath para encontrar o caminho mais curto
// entre Roberto e cada usuário com idade entre 25 e 35 anos,
// passando por qualquer tipo de relacionamento.
// O resultado mostra o alvo, sua idade e a profundidade do caminho.
// -----------------------------------------------------------------
/ -----------------------------------------------------------------
// O objetivo dessa query é direcionar uma propaganda a pessoas de
// 25 a 35 anos ligadas ao Roberto.
// Além disso ela mostra a quantidade de saltos mínimos até o 
// alvo para determinar um eventual custo da plataforma com base em
// distancia.
// -----------------------------------------------------------------

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


// -----------------------------------------------------------------
// Q2 (Alternativa sem APOC): Mesma query usando cálculo de idade
//    com date() nativo do Neo4j >= 5.x
// -----------------------------------------------------------------

MATCH (roberto:Usuario {email:'roberto@email.com'})
MATCH (alvo:Usuario)
WHERE alvo <> roberto
WITH roberto, alvo,
     split(alvo.dataNascimento, '/') AS partes
WITH roberto, alvo, partes,
     date(partes[2] + '-' + partes[1] + '-' + partes[0]) AS dtNasc
WITH roberto, alvo, dtNasc,
     duration.between(dtNasc, date('2026-03-14')).years AS idade
WHERE idade >= 25 AND idade <= 35
MATCH path = shortestPath((roberto)-[*1..6]-(alvo))
RETURN alvo.nome           AS Nome,
       alvo.dataNascimento AS DataNascimento,
       idade               AS Idade,
       length(path)        AS SaltosMinimos,
       [n IN nodes(path) WHERE n:Usuario | n.nome] AS CaminhoUsuarios
ORDER BY SaltosMinimos ASC;


// -----------------------------------------------------------------
// Q3: Quem são os amigos diretos do Roberto? (1 salto)
// -----------------------------------------------------------------

MATCH (roberto:Usuario {email:'roberto@email.com'})-[:E_AMIGO_DE]->(amigo:Usuario)
RETURN amigo.nome AS Amigo, amigo.dataNascimento AS Nascimento
ORDER BY amigo.nome;


// -----------------------------------------------------------------
// Q4: Quais posts o Roberto curtiu, comentou ou compartilhou?
// -----------------------------------------------------------------

MATCH (roberto:Usuario {email:'roberto@email.com'})-[r:CURTIU_O_POST|COMENTOU_O_POST|COMPARTILHOU_O_POST]->(a:Acao)-[:PERTENCE_AO_POST]->(p:Post)
RETURN type(r) AS TipoAcao, p.titulo AS Post, a.dataHora AS DataHora
ORDER BY a.dataHora;


// -----------------------------------------------------------------
// Q5: Comunidades mais ativas (por número de posts)
// -----------------------------------------------------------------

MATCH (p:Post)-[:PERTENCE_A]->(c:Comunidade)
RETURN c.nome AS Comunidade, count(p) AS TotalPosts
ORDER BY TotalPosts DESC;


// -----------------------------------------------------------------
// Q6: Usuários que participam de mais de uma comunidade
// -----------------------------------------------------------------

MATCH (u:Usuario)-[:PERTENCE_A]->(c:Comunidade)
WITH u, count(c) AS totalComunidades
WHERE totalComunidades > 1
RETURN u.nome AS Usuario, totalComunidades
ORDER BY totalComunidades DESC;


// -----------------------------------------------------------------
// Q7: Posts com maior engajamento (curtidas + comentários + compartilhamentos)
// -----------------------------------------------------------------

MATCH (a:Acao)-[:PERTENCE_AO_POST]->(p:Post)
RETURN p.titulo AS Post, p.autor AS Autor, count(a) AS TotalInteracoes
ORDER BY TotalInteracoes DESC
LIMIT 10;


// -----------------------------------------------------------------
// Q8: Grau de conexão de cada usuário (número de amigos)
// -----------------------------------------------------------------

MATCH (u:Usuario)-[:E_AMIGO_DE]->(outro:Usuario)
RETURN u.nome AS Usuario, count(outro) AS NumeroDeAmigos
ORDER BY NumeroDeAmigos DESC;


// -----------------------------------------------------------------
// Q9: Usuários que NÃO pertencem a nenhuma comunidade
// -----------------------------------------------------------------

MATCH (u:Usuario)
WHERE NOT (u)-[:PERTENCE_A]->(:Comunidade)
RETURN u.nome AS UsuarioSemComunidade;


// -----------------------------------------------------------------
// Q10: Encontrar pontes sociais — usuários que conectam dois
//      grupos que não se conectariam de outra forma
//      (betweenness simplificado: nós que aparecem em caminhos
//       entre Roberto e usuários distantes)
// -----------------------------------------------------------------

MATCH (roberto:Usuario {email:'roberto@email.com'}), (alvo:Usuario)
WHERE alvo <> roberto
MATCH path = shortestPath((roberto)-[*1..5]-(alvo))
WHERE length(path) > 2
UNWIND nodes(path)[1..-1] AS intermediario
WITH intermediario, count(DISTINCT alvo) AS caminhosCobertos
WHERE intermediario:Usuario
RETURN intermediario.nome AS PonteSocial, caminhosCobertos
ORDER BY caminhosCobertos DESC
LIMIT 5;

// -----------------------------------------------------------------
// Q11: Sugestão de amigos — "Pessoas que você talvez conheça"
//      Baseado em amigos de amigos com contagem de conexões comuns
// -----------------------------------------------------------------

MATCH (eu:Usuario {email:'roberto@email.com'})

// Passo 1: mapear todos os amigos diretos
MATCH (eu)-[:E_AMIGO_DE]->(amigoDireto:Usuario)

// Passo 2: a partir de cada amigo direto, alcançar os amigos dele
MATCH (amigoDireto)-[:E_AMIGO_DE]->(candidato:Usuario)

// Passo 3: excluir o próprio usuário e seus amigos já existentes
WHERE candidato <> eu
  AND NOT (eu)-[:E_AMIGO_DE]->(candidato)

// Passo 4: agregar — contar amigos em comum e listá-los
WITH eu, candidato,
     collect(DISTINCT amigoDireto.nome) AS amigoEmComum,
     count(DISTINCT amigoDireto)        AS totalEmComum

// Passo 5: ordenar pelos que têm mais conexões em comum
ORDER BY totalEmComum DESC

RETURN candidato.nome          AS SugestaoDAmigo,
       candidato.dataNascimento AS Nascimento,
       totalEmComum             AS AmigoEmComumCount,
       amigoEmComum             AS QuaisSaoOsAmigosEmComum
LIMIT 10;
