# A randonly generated user
def user_rand
  user = User.new
  user.username  = rand_username
  user.email     = "#{user.username}@example.com"
  user.password_conf = \
  user.password  = 'passw0rd'
  return user
end


# Helpers #

def rand_username
  /[:name:]_\d\d/.gen.downcase.tr(' ','_')
end