# frozen_string_literal: true

unless User.exists?('miguel.urbina@michelada.io')
  User.create(email: 'miguel.urbina@michelada.io', password: 'adminUser',
              name: 'Miguel Ángel Urbina', role: 2)
end
