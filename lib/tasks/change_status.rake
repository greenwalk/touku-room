namespace :change_status do

  desc "Create a New Field."
  task create_new_field: :environment do
    # "終わったFieldのステータスを変更"
    fields = Field.where(status: "voting")
    finished_field = fields.order(updated_at: :desc)[-1]
    finished_field.update(status: "finished")
    # "新しいFieldを作成し、top_themeと紐づける"
    themes = Theme.where(status: "set")
    top_theme = themes.order(updated_at: :desc)[-1]
    Field.create(status: "touku", theme_id: top_theme.id)
    # "top_themeのステータスを変更"
    themes = Theme.where(status: "set")
    top_theme = themes.order(updated_at: :desc)[-1]
    top_theme.update(status: "used")
  end

  desc "Change the field's status from touku to voting."
  task chage_field_status: :environment do
    fields = Field.where(status: "touku")
    touku_field = fields.order(updated_at: :desc)[-1]
    touku_field.update(status: "voting")
  end
end
