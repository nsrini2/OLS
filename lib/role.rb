class Role
attr_reader :key, :id

private
@@roles=Set.new
@@role_id_map={}

def initialize(key,id)
@key=key
@id=id
@@roles << self
@@role_id_map[id]=self
end

public
None=Role.new(:none,0)
Admin=Role.new(:admin,1)
LeaveApprover=Role.new(:leave_approver,2)

def self.roles
  @@roles
end

def to_s
  {@key => @id}
end

def self.find(role_id)
   @@role_id_map[role_id]
end

def self.find_all(*role_ids)
   role_ids.collect{|x| @@role_id_map[x]}
end

end
