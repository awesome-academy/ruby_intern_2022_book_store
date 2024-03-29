require "grape-swagger"

module Api
  module V1
    class Base < Grape::API
      mount V1::Users
      mount V1::Auth
      mount V1::Books
      add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/api/v1/swagger_doc",
        hide_format: true
      )
    end
  end
end
