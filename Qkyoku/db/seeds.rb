# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'ad@ad.com',
  password: '111111'
)

sections = Section.create!(
  [
    {name: 'エンジン'}, 
    {name: 'インパネ'},
    {name: 'ガラス'},
    {name: 'タイヤ'},
    {name: 'ドア'}
  ]
)

execution_statuses = ExecutionStatus.create!(
  [
    {name: '未着手'},
    {name: '実行中'},
    {name: '完了'},
  ]
)

workplaces = Workplace.create!(
  [
    {name: '1P職場', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/kouteizu.jpg"), filename: 'kouteizu.jpg'), is_checked: true}
  ]  
)

users = User.create!(
  [
    {email: 'sat@test.com', name: '佐藤', password: 'ssttuu'},
    {email: 'yam@test.com', name: '山田', password: 'yymmdd'},
    {email: 'suz@test.com', name: '鈴木', password: 'sszzkk'}
  ]
)

posts = Post.create!(
  [
    {title: '立ち作業で足が痛くなる', post_body: '一日中立ち作業で作業場の床が硬いため足裏が痛くなり、疲労も溜まりやすいです。足場を柔らかくすることは可能でしょうか？', section_id: sections[1].id, user_id: users[0].id },
    {title: 'ホイールが搬送されてこない', post_body: 'エアーローラーの回転が悪くホイールが搬送されてこない。空気圧の調整をしたが、治らず原因がわからない。', section_id: sections[3].id, user_id: users[1].id },
  ]
)

comments = Comment.create!(
  [
    {comment_body: '疲労軽減マットを敷きました。これで少しは楽になると思います。', execution_status_id: execution_statuses[2].id, post_id: posts[0].id, user_id: users[2].id },
    {comment_body: '15日に対応します。', execution_status_id: execution_statuses[0].id, post_id: posts[1].id, user_id: users[2].id }
  ]
)

