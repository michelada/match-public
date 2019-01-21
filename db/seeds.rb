# frozen_string_literal: true

Team.find_or_create_by(name: 'michelada')

unless User.exists?('miguel.urbina@michelada.io')
  User.create(email: 'miguel.urbina@michelada.io', password: 'adminUser',
              name: 'Miguel Ángel Urbina', role: 2, team_id: 1)
end
