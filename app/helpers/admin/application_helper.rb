module Admin::ApplicationHelper
    def roles
        {
            'Manager' => 'manager',
            'Editor' => 'editor',
            'Viewer' => 'viewer'
        }
    end
end
