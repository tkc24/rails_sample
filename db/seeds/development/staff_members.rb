StaffMember.create!(
  email: 'nishi@example.com',
  family_name: '西',
  given_name: '武史',
  family_name_kana: 'ニシ',
  given_name_kana: 'タケシ',
  password: 'password',
  start_date: Date.today
)
StaffMember.create!(
  email: 'test@example.com',
  family_name: 'てすと',
  given_name: '太郎',
  family_name_kana: 'テスト',
  given_name_kana: 'タロウ',
  password: 'password',
  start_date: Date.today,
  suspended: true
)
