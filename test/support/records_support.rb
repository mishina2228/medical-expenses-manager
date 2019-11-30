module RecordsSupport
  def new_record
    hospital1 = hospitals(:病院1)
    person1 = people(:ユーザー1)
    Record.new(
      date: Time.zone.today,
      cost: rand(100..10_000),
      division_id: hospital1.id,
      person_id: person1.id
    )
  end
end
