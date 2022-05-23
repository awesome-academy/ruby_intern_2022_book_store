module Api
  module V1
    class Books < Grape::API
      include Api::V1::Defaults

      helpers do
        def handle_fail
          api_error! "failure"
        end

        def authenticate_admin!
          token = request.headers["Jwt-Token"]
          if AuthToken.find_by token: token
            user_id = Authentication.decode(token)["user_id"] if token
            @current_user ||= User.find_by id: user_id
          end
          return if @current_user.admin?

          api_error!("You need to log in to use the app", "failure", 401, {})
        end
      end

      resource :books do
        desc "Return all books"
        get "", root: "books" do
          Book.all.newest
        end

        desc "Return a book"
        params do
          requires :id, type: String, desc: "ID of the book"
        end
        get ":id", root: :books do
          product = Book.find_by id: params[:id]
          return product if product

          error!("Book not found", 404)
        end
      end

      resource :books do
        desc "Create a book"
        params do
          requires :book, type: JSON do
            requires :name, type: String
            requires :description, type: String
            optional :publish_year, type: DateTime
            requires :publisher_id, type: String
            requires :category_id, type: String
            requires :price, type: String
          end
        end
        post "", root: :books do
          authenticate_admin!
          if Book.create(params["book"])
            present success: "success"
          else
            handle_fail
          end
        end
      end
      resource :books do
        desc "Update a book's information"
        params do
          requires :book, type: JSON do
            requires :id, type: String
            requires :name, type: String
            requires :description, type: String
            optional :publish_year, type: DateTime
            requires :publisher_id, type: String
            requires :category_id, type: String
            requires :price, type: String
          end
        end
        put ":id", root: :books do
          authenticate_admin!
          if Book.update(params["book"])
            present success: "success"
          else
            handle_fail
          end
        end
      end
    end
  end
end
