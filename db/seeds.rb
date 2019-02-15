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

Activity.find_or_create_by(name: 'Curso básico Android Studio', english: false, activity_type: 0,
                           description: 'Nos adentramos en el entorno de desarrollo Android Studio, donde conoceremos sus modulos más utilzados,
                           las herramientas de depuracion que nos ofrece y la forma de trabajo',
                           pitch_audience: 'Alumnos cursantes o que cursarán la asignatura "Tecnologías móviles y responsibas" en el Tecnológico
                           de Colima', abstract_outline: 'Conociendo el IDE, modulos, MVC, Vista, Controlador, como ligar el controlador con la vista,
                           manipulado widgets, AVD, emulador Android, debugear una aplicación', user_id: 1, score: 40, status: 2)

Activity.find_or_create_by(name: 'Curso básico Git', english: false, activity_type: 0, user_id: 1,
                           description: 'Se enseñaran los principales comandos utilizados en Git, casos de uso y buenas prácticas de desarrollo.',
                           pitch_audience: 'Toda persona que se encuentre en el area de desarrollo que no sepa utilizar Git o que desee mejorar su
                           habilidades', abstract_outline: 'Que es un sistema de control de versiones, de donde nace Git, para qué utilizar Git,
                           Github y Gitlab como plataformas para el desarrollo en equipo, principales comandos de Git, buenas practicas', score: 40)

Activity.find_or_create_by(name: '¿Qué es CRUD?', english: false, activity_type: 1, user_id: 2, score: 25)

Activity.find_or_create_by(name: 'La importancia del diseño en el desarrollo', english: true, activity_type: 1,
                           description: 'Por lo general se suele ver al diseño como lo que pinta las vistas de lo desarrollado, sin embargo,
                           el diseño va más allá que solo esto', pitch_audience: 'Personas involucradas en el desarrollo de software, cursantes de
                           de alguna carrera a fin', abstract_outline: 'Como nace el diseño, la necesidad de generar un mejor aspecto visual,
                           planeación de las interfaces, se podría sin diseño?, la comodidad del usuario, interaccion humano maquina',
                           user_id: 2, score: 30, status: 2)

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
