NutritionData::Application.routes.draw do
  scope(path: '/api', defaults: {format: :json}) do
    resources :foods, only: [:index, :show]
  end
end
