module VisibilityScopeableModel
  extend ActiveSupport::Concern

  def is_visibled_by(user, role)
    self.class.visibled_by(user, role).where(id: id).any?
  end

  module ClassMethods
    def visibled_by(user, role)
      roles_user = RolesUser.find_by!(role_id: role.id, user_id: user.id)
      return all if roles_user.is_visible_all

      if role.role_code == "HEAD_COORDINATOR"
        scope_proc = scope_procs["HeadCoordinator"]
        return none if scope_proc.nil?
        scope_proc.call(roles_user.visibility_ids.try(:split, "|"))
      else
        scope_proc = scope_procs[role.visibility_type]
        return none if scope_proc.nil?
        visibility = role.visibility_type.to_s.constantize.find_by!(id: roles_user.visibility_id)
        scope_proc = scope_procs[role.visibility_type]
        scope_proc.call(visibility)
      end
    end

    # def visibled_search_conditions(user, role, other_conditions = {})
    #   other_conditions.compact!

    #   all_condition  = other_conditions.any? ? other_conditions : nil
    #   none_condition = { id: [] }

    #   roles_user = RolesUser.find_by!(role_id: role.id, user_id: user.id)

    #   return all_condition if roles_user.is_visible_all
    #   return none_condition unless scope_procs.keys.include?(role.visibility_type)

    #   field_name = "#{role.visibility_type.underscore}_id".to_sym
    #   conditions = { field_name => roles_user.visibility_id }

    #   if other_conditions[field_name] && other_conditions[field_name] != conditions[field_name]
    #     # force to none if value of the same key not equal
    #     other_conditions[field_name] = []
    #   end

    #   conditions.merge(other_conditions)
    # end

    private

    attr_reader :scope_procs

    def visibility_scope(values)
      @scope_procs = {}
      values.each do |visibility_type, p|
        @scope_procs[visibility_type.to_s.camelcase] = p
      end
    end
  end
end
