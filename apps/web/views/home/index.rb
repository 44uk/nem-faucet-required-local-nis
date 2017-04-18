module Web::Views::Home
  class Index
    include Web::View

    def form_drawing
      form_for :drawing, routes.drawings_path, values: { drawing: drawing } do
        div(class: 'row') do
          div(class: 'col m8') do
            div do
              label :address
              text_field :address, class: '_width100'
            end
            div do
              label :message
              text_field :message, class: '_width100'
            end
          end
          div(class: 'col m4') do
            label raw '&nbsp;'
            submit 'Draw!', class: 'button _primary _width100'
          end
        end
      end
    end
  end
end
