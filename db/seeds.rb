# frozen_string_literal: true

Team.find_or_create_by(name: 'distortable_intonation')
Team.find_or_create_by(name: 'convertible_baggage')
Team.find_or_create_by(name: 'rakish_weave')

unless User.exists?('normal_user@michelada.io')
  User.create(email: 'normal_user@michelada.io', password: 'normalUser',
              name: 'Usuario Random', role: 0, team_id: 1)
end

unless User.exists?('normal_user_2@michelada.io')
  User.create(email: 'normal_user_2@michelada.io', password: 'normalUser',
              name: 'José Juan', role: 0, team_id: 1)
end

unless User.exists?('judge_user@michelada.io')
  User.create(email: 'judge_user@michelada.io', password: 'judgeUser',
              name: 'Usuario Juez', role: 1, team_id: 1)
end

unless User.exists?('judge_user_2@michelada.io')
  User.create(email: 'judge_user_2@michelada.io', password: 'judgeUser',
              name: 'Usuario Juez 2', role: 1, team_id: 2)
end

unless User.exists?('judge_user_3@michelada.io')
  User.create(email: 'judge_user_3@michelada.io', password: 'judgeUser',
              name: 'Usuario Juez 3', role: 1, team_id: 3)
end

unless User.exists?('admin_user@michelada.io')
  User.create(email: 'admin_user@michelada.io', password: 'adminUser',
              name: 'Usuario Administrador', role: 2)
end

Activity.find_or_create_by(name: 'Curso básico Android Studio', english: false, activity_type: 0, user_id: 1, score: 40, status: 2)

Activity.find_or_create_by(name: 'Curso básico Git', english: false, activity_type: 0, user_id: 1, score: 40)

Activity.find_or_create_by(name: '¿Qué es CRUD?', english: false, activity_type: 1, user_id: 2, score: 25)

Activity.find_or_create_by(name: 'La importancia del diseño en el desarrollo', english: true, activity_type: 1, user_id: 2, score: 30, status: 2)

Activity.find_or_create_by(name: 'ROR as a day-to-day', english: true, activity_type: 2, user_id: 4, score: 10)

ActivityStatus.create(activity_id: 1, user_id: 4, approve: true)

ActivityStatus.create(activity_id: 1, user_id: 5, approve: true)

ActivityStatus.create(activity_id: 2, user_id: 3, approve: true)

ActivityStatus.create(activity_id: 2, user_id: 4, approve: true)

ActivityStatus.create(activity_id: 2, user_id: 5, approve: true)

ActivityStatus.create(activity_id: 3, user_id: 3, approve: true)

ActivityStatus.create(activity_id: 3, user_id: 4, approve: true)

ActivityStatus.create(activity_id: 4, user_id: 3, approve: true)

ActivityStatus.create(activity_id: 4, user_id: 4, approve: true)

ActivityStatus.create(activity_id: 4, user_id: 5, approve: true)

Feedback.create(comment: 'Recuerda que debes agregar el archivo adjugto, o en todo caso, agregar el link hacia el repositorio que lo contiene',
                activity_id: 1, user_id: 5)

Feedback.create(comment: 'Muuuy bien, quedó chido el contenido, aunque al ser práctico, deja una falta de material de apoyo', activity_id: 1, user_id: 4)
