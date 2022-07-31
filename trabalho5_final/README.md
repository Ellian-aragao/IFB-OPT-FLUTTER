# trabalho5_final - ToDo list projeto pessoal

O projeto foi escolhido devido desejo de criar um app de todo list do qual
possuo a muito tempo, sendo esta apenas uma prévia de implementação referência
a ser evoluída ao longo do tempo, a inspiração de features é advinda de diversos
apps de produtividade dos quais já utilizei durante a vida, sendo o ticktick
o que me agradou e o qual busquei de referencia para criação deste.

O desenvolvimento deste, fora feito através de um fork de toda a implementação
do trabalho 3, sendo assim, com muitos elementos iguais de fato, visto a não
necessidade de se reinventar a roda, entretanto, sendo detalhes que devam ser
alterados de maneira oportuna posteriormente

este projeto visa ser uma referência de arquitetura para o desenvolvimento de
completo da aplicação desejada, e sua implementação facilita a criação de novas
features conforme pode-se observar na arquitetura deste.

## Arquitetura

### infrastructure

#### persistência

Camada responsável por lidar com acesso ao mundo externo, no presente momento
tendo a implementação referência de 3 modelos de persistência:

- memória
- sqlite
- firebase

Faltando a implementação de persistência através de uma API utilizando chamadas
Http, entretanto, visto a necessidade de um back-end para receber essas chamadas
não fora desenvolvido.

#### providers

camada responsável pela injeção de dependência dos objetos, utilizando do mecanismo
provido pela biblioteca provider. Além da criação de uma factory que encapsularia
a forma de criação destes componentes e isolando o funcionamento e injeção dos dados
necessários para atuar com os sistemas de persistência. Assim só chamando somente
o método relativo ao sistema de persistência desejado para utilização no app, ou
até mesmo uma composição destes.

#### logging

Devido a não existência de um componente claro de log e tratamento deste, além
do costume em atuar com tecnologias java, como log através da biblioteca
logback, fora feita uma interface referência para o tratamento de logs, sendo
assim adaptando para troca do sistema de log de forma facilitada.

### model

Camada relativa as entidades do sistema, do qual trata-se ainda só de uma classe.

### service

camada responsável pelos usecases do model, sendo esta a responsabilidade de
utilizar o model para interação com o mundo externo, e utilizando injeção de
dependência para tornar-se agnostico dos sistemas de busca e persistência.

### view

camada responsável pela interação com o usuário e utilização dos usecases para
criação de views.

#### component

isolamento de lógicas básicas e que seriam reutilizadas nas views
