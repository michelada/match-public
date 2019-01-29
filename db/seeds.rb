# frozen_string_literal: true

Team.find_or_create_by(name: 'michelada')

unless User.exists?('normal_user@michelada.io')
  User.create(email: 'normal_user@michelada.io', password: 'normalUser',
              name: 'Usuario Random', role: 0, team_id: 1)
end

unless User.exists?('judge_user@michelada.io')
  User.create(email: 'judge_user@michelada.io', password: 'judgeUser',
              name: 'Usuario Juez', role: 1, team_id: 1)
end

unless User.exists?('judge_user_2@michelada.io')
  User.create(email: 'judge_user_2@michelada.io', password: 'judgeUser',
              name: 'Usuario Juez 2', role: 1, team_id: 1)
end

unless User.exists?('judge_user_3@michelada.io')
  User.create(email: 'judge_user_3@michelada.io', password: 'judgeUser',
              name: 'Usuario Juez 3', role: 1, team_id: 1)
end

unless User.exists?('admin_user@michelada.io')
  User.create(email: 'admin_user@michelada.io', password: 'adminUser',
              name: 'Usuario Administrador', role: 2)
end

Location.find_or_create_by(name: 'UDC')

Activity.find_or_create_by(name: 'Intro a Android Studio', english: false, activity_type: 1, user_id: 1)

Activity.find_or_create_by(name: '¿Qué es CRUD?', english: false, activity_type: 0, user_id: 1)

Activity.find_or_create_by(name: 'ROR as a day-to-day', english: true, activity_type: 2, user_id: 1)
