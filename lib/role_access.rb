module RoleAccess

    def roles    
      roles = (super || "") unless @roles_set_cache
      unless @roles_set_cache
        if roles.blank?
          @roles_set_cache = Set.new
        else
          @roles_set_cache = Role.find_all(*roles.split(',').map(&:to_i)).to_set.freeze
        end
      end
      @roles_set_cache
    end

    def role_keys
      @role_key_set_cache ||= roles.collect(&:key)
    end

    def roles=(new_roles)
      @roles_set_cache = nil
      self[:roles] = new_roles.collect(&:id).join(',')
    end

    def add_roles(*r)
      self.roles = roles.dup.merge(r)
    end

    def remove_roles(*r)
      self.roles = roles.dup.subtract(r)
    end

    def has_role?(*r)
      r.any?{|x| roles.dup.member?(x)}
    end
    
    def is_admin?()
       has_role?(Role::Admin)
    end
    
    def is_leave_approver?()
       has_role?(Role::LeaveApprover)
    end
    
end
