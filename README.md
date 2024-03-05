### Desafio para vaga de BackEnd - Foco em Ruby On Rails:

Objetivo do Desafio:

O objetivo deste desafio é avaliar suas habilidades no desenvolvimento com o framework Ruby On Rails, bem como quaisquer integrações necessárias, a implementação de funcionalidades que executam em segundo plano de forma síncrona, a escrita de testes e a criação de uma documentação clara.

#### Requisitos:

- ruby-3.1.4
- sqlite3
- redis-cli 7.2.4

#### Comecando:
Clone o projeto e ao executar:

```ruby
bundle install
rails db:migrate
rails db:seed
rails s

# em outro terminal, redis tem que estar em execução
bundle exec sidekiq
```

#### Test:
```ruby
bundle install
rails db:create RAILS_ENV=test
rails db:migrate RAILS_ENV=test
rails db:seed RAILS_ENV=test
rails rspec
```