module RecordsSupport
  def new_record
    hospital1 = hospitals(:hospital1)
    person1 = people(:user1)
    Record.new(
      date: Date.current,
      cost: rand(100..10_000),
      division_id: hospital1.id,
      person_id: person1.id
    )
  end
end
