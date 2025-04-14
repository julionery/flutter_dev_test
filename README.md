# Aplicativo de Autenticação TOTP

Um aplicativo Flutter que implementa autenticação segura com suporte a TOTP (Time-based One-Time Password) como teste de desenvolvedor flutter para 7COMm.

## Tecnologias Utilizadas

### Core
- **Flutter 3.3+**: Framework para desenvolvimento cross-platform
- **Dart 3.3+**: Linguagem de programação
- **Clean Architecture**: Arquitetura modular com separação de responsabilidades
- **BLoC/Cubit**: Gerenciamento de estado utilizando separação entre UI e lógica de negócios
- **Dependency Injection**: Injeção de dependências manual para inversão de controle
- **Unit Testing**: Testes unitários para garantir a qualidade do código

### Pacotes Principais
- `flutter_bloc` (9.1.0): Implementação do padrão BLoC para gerenciamento de estado
- `equatable` (2.0.7): Facilita a comparação de objetos
- `http` (1.3.0): Cliente HTTP para comunicação com APIs RESTful
- `otp` (3.1.4): Geração e validação de códigos TOTP
- `intl` (0.19.0): Internacionalização e localização
- `flutter_svg` (2.0.17): Renderização de imagens SVG

### Desenvolvimento e Testes
- `bloc_test` (10.0.0): Ferramentas para testar componentes BLoC/Cubit
- `mockito` (5.4.4): Framework de mock para testes
- `build_runner` (2.4.13): Geração de código

## Arquitetura do Projeto

O projeto segue princípios da Clean Architecture com as seguintes camadas:

### Core
Componentes e utilitários fundamentais utilizados por toda a aplicação:
- **DI (Dependency Injection)**: Injeção de dependências
- **Foundations**: Componentes de UI como cores, espaçamentos e tipografia
- **Utils**: Utilitários como constantes, exceções e funções auxiliares

### Data
Implementação de repositórios e fontes de dados:
- **Models**: Representações de dados para transferência
- **DataSources**: Fontes de dados (remote, local)
- **Repositories**: Implementações de repositórios

### Domain
Regras de negócio e entidades da aplicação:
- **Entities**: Modelos de domínio
- **Repositories**: Interfaces de repositórios
- **UseCases**: Casos de uso da aplicação

### Presentation
Camada de UI da aplicação:
- **Cubits**: Gerenciadores de estado baseados em BLoC
- **Features**: Telas da aplicação
- **Widgets**: Componentes reutilizáveis

## Principais Funcionalidades

### Autenticação
- Login com email e senha
- Autenticação de dois fatores com TOTP
- Recuperação de senha com código de verificação

### Segurança
- Implementação de TOTP (Time-based One-Time Password)
- Validação de entrada para evitar ataques
- Tratamento de exceções para diferentes cenários de erro

### Experiência do Usuário
- Design responsivo
- Feedback visual para ações do usuário
- Mensagens de erro contextualizadas
- Suporte a múltiplos idiomas (i18n)

## Padrões de Design Implementados

### Repository Pattern
Abstração da fonte de dados permitindo trocar a implementação sem afetar o restante do código.

### Factory Pattern
Utilizado em service locators para criação de instâncias de objetos.

### Observer Pattern
Implementado via BLoC/Cubit para atualização da UI baseada em mudanças de estado.

### Strategy Pattern
Utilizado no tratamento de erros e validações.

## Como Executar o Projeto

### Requisitos
- Flutter 3.3 ou superior
- Dart 3.3 ou superior

### Passos para Execução

1. Clone o repositório:
```bash
git clone [repository_url]
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
flutter run
```

### Executando Testes

Execute os testes unitários:
```bash
flutter test
```

## Estrutura de Diretórios

```
lib/
├── generated/          # Arquivos gerados (i18n)
├── src/
│   ├── core/           # Componentes fundamentais
│   │   ├── di/         # Injeção de dependências
│   │   ├── foundations/# Definições de design 
│   │   └── utils/      # Utilitários
│   ├── data/           # Camada de dados
│   │   ├── datasources/# Fontes de dados
│   │   ├── models/     # Modelos de dados
│   │   └── repositories/# Implementações de repositórios
│   ├── domain/         # Regras de negócio
│   │   ├── entities/   # Entidades de domínio
│   │   ├── repositories/# Interfaces de repositórios
│   │   └── usecases/   # Casos de uso
│   └── presentation/   # Interface do usuário
│       ├── cubits/     # Estado e lógica da UI
│       ├── features/   # Telas e componentes
│       └── widgets/    # Widgets reutilizáveis
└── main.dart           # Ponto de entrada
```

## Boas Práticas Implementadas

- **Separation of Concerns**: Cada classe tem uma responsabilidade única
- **Dependency Inversion**: Dependências são injetadas e não instanciadas diretamente
- **Error Handling**: Tratamento de erros centralizado e especializado
- **Testability**: Código escrito para ser facilmente testável
- **Clean Code**: Convenções de nomenclatura e estruturação claras


## Configuração do Backend

O backend é necessário para testar a funcionalidade do aplicativo. Para configurar e executar a API, siga as instruções no
arquivo `api/README.md` localizado no repositório base.

1. Acesse o diretório `api` no repositório base.
2. Siga as instruções no `README.md` para instalar as dependências e iniciar o servidor.
3. O servidor deve estar disponível em `http://127.0.0.1:5000`.

### Endpoints Disponíveis

1. **POST** `/auth/login`:
    - Verifica as credenciais do usuário e um código TOTP gerado.
    - Corpo da requisição:
      ```json
      {
        "username": "admin",
        "password": "password123",
        "totp_code": "<generated_totp_code>"
      }
      ```

2. **POST** `/auth/recovery-secret`:
    - Retorna o secret TOTP quando fornecido o código de recuperação correto (`000010`).
    - Corpo da requisição:
      ```json
      {
        "username": "admin",
        "password": "password123",
        "code": "000010"
      }
      ```

## Contribuição

1. Faça o fork do projeto
2. Crie sua branch de feature (`git checkout -b feature/amazing-feature`)
3. Commit suas mudanças (`git commit -m 'Add some amazing feature'`)
4. Push para a branch (`git push origin feature/amazing-feature`)
5. Abra um Pull Request

## Licença

Distribuído sob a licença MIT. Veja `LICENSE.md` para mais informações.
