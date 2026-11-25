# Site Núcleo Viva — www.nviva.com.br

Site com **backend em Java** (Spring Boot + banco SQLite) e **frontend em HTML, CSS e JavaScript**.
O navegador só entende HTML, CSS e JavaScript, por isso a parte visual usa essas três linguagens;
toda a parte do servidor (login, banco de dados, fotos, usuários) está em Java.

## Onde está cada parte do código

| O que você quer mudar | Arquivo |
| --- | --- |
| Textos, seções e menus da página | `src/main/resources/static/index.html` |
| Cores, degradê, tamanhos, aba lateral | `src/main/resources/static/styles.css` |
| Comportamento da página (aba lateral, painel) | `src/main/resources/static/app.js` |
| Logo | `src/main/resources/static/logo.jpg` |
| Início do servidor Java | `src/main/java/br/com/nviva/NucleoVivaApplication.java` |
| Criação do banco e textos padrão | `src/main/java/br/com/nviva/config/BancoDeDados.java` |
| Login, sair e troca de senha | `src/main/java/br/com/nviva/controller/LoginController.java` |
| Textos do site (Dados do site) | `src/main/java/br/com/nviva/controller/SiteController.java` |
| Programação dos 6 programas | `src/main/java/br/com/nviva/controller/ProgramacaoController.java` |
| Endereços (Onde Estamos) | `src/main/java/br/com/nviva/controller/LocalController.java` |
| Fotos e galeria | `src/main/java/br/com/nviva/controller/FotoController.java` |
| Acessos dos professores | `src/main/java/br/com/nviva/controller/UsuarioController.java` |
| Porta, banco, limite de fotos | `src/main/resources/application.properties` |
| Usuário e senha do administrador | `config/application.properties` (não publicar) |

Os 6 programas da aba lateral: Copa Revelando Talentos, Copa da Amizade, Festival da Alegria,
Brincando no Parque, De Férias no Clube e Rua da Gente.

## Como abrir e rodar no VS Code (Windows)

1. **Extraia o ZIP** (botão direito > *Extrair tudo*). O VS Code não abre arquivos .zip diretamente.
2. Abra o VS Code > *Arquivo > Abrir Pasta* > escolha a pasta `nucleo_viva_java`.
3. Aceite instalar as extensões recomendadas (**Extension Pack for Java**). Se não aparecer o aviso,
   procure "Extension Pack for Java" na aba de extensões.
4. Dê dois cliques em `iniciar.cmd`. Na primeira execução, ele baixa o JDK 25 e o Maven para a pasta local `.mvn` se ainda não estiverem disponíveis.
5. O site abre em http://localhost:3000 no navegador. Para encerrar, pressione **Ctrl+C** na janela do inicializador.

Na primeira execução, é preciso ter conexão com a internet para baixar o JDK, o Maven e as bibliotecas do projeto.

## Área dos Professores

Login e senha iniciais: arquivo `ACESSO_AREA_PROFESSORES.txt`.
No painel: dados do site, programação, endereços, fotos, usuários e senha.

## Dados

- Banco: `data/nviva.sqlite` (criado sozinho).
- Fotos enviadas: `uploads/`.
- Faça backup dessas duas pastas.

## Publicar na internet

Contrate uma hospedagem que rode Java, envie o projeto, crie o `config/application.properties` no servidor,
ative HTTPS (e mude `server.servlet.session.cookie.secure=true`) e aponte o domínio `www.nviva.com.br`.
Antes de divulgar fotos de crianças, confira as autorizações dos responsáveis.
