unless User.exists?('admin_user@michelada.io')
  User.create(email: 'admin_user@michelada.io', password: 'adminUser',
              name: 'Usuario Administrador', role: 2)
end
