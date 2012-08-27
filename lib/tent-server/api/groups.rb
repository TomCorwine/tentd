module TentServer
  class API
    class Groups
      include Router

      class GetAll < Middleware
        def action(env, params, request)
          env['response'] = Model::Group.all
          env
        end
      end

      class GetOne < Middleware
        def action(env, params, request)
          if group = Model::Group.get(params[:group_id])
            env['response'] = group
          end
          env
        end
      end

      class Update < Middleware
        def action(env, params, request)
          if group = Model::Group.get(params[:group_id])
            group_attributes = params[:data]
            group.update(group_attributes)
            env['response'] = group.reload
          end
          env
        end
      end

      class Create < Middleware
        def action(env, params, request)
          group_attributes = params[:data]
          env['response'] = Model::Group.create!(group_attributes)
          env
        end
      end

      get '/groups' do |b|
        b.use GetAll
      end

      get '/groups/:group_id' do |b|
        b.use GetOne
      end

      put '/groups/:group_id' do |b|
        b.use Update
      end

      post '/groups' do |b|
        b.use Create
      end
    end
  end
end