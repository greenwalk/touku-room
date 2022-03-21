namespace :change_status do
  desc 'Create a New Field.'
  task create_new_field: :environment do
    logger = Logger.new 'log/cron.log'

    # "終わったFieldを取得"
    fields = Field.where(status: 'voting')
    finished_field = fields.order(updated_at: :desc)[-1]
    # "終わったFieldの一位の回答を取得"
    top_haiku = finished_field.haikus.sort { |a, b| b.votes.size <=> a.votes.size }[0]
    top_user = top_haiku.user
    top_theme = top_user.themes.where(status: "set")[0]
    # "終わったFieldのステータスを変更"
    finished_field.update(status: 'finished')
    # "新しいFieldを作成し、top_themeと紐づける"
    Field.create(status: 'touku', theme_id: top_theme.id)
    # "top_themeのステータスを変更"
    top_theme.update(status: 'used')
  end

  desc "Change the field's status from touku to voting."
  task chage_field_status: :environment do
    logger = Logger.new 'log/cron.log'

    fields = Field.where(status: 'touku')
    touku_field = fields.order(updated_at: :desc)[-1]
    touku_field.update(status: 'voting')
  end
end
