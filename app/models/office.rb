class Office < ApplicationRecord

  belongs_to :district
  has_many :reps

  def self.find_reps(args = {})
    # Accepts hash containing
    # location: (state)
    # office_type: (senate, house, executive)
    @level =       args.fetch(:level, 'national')
    @state =       args.fetch(:state, 'ca')
    @county =      args[:county]
    @office_type = args[:office_type]
    @name =        args[:name]


    # Rep.joins(:office).where('division_id LIKE ? AND reps.name LIKE ?', '%cd:%', '%Nancy%')
    # to find reps by state
    if @level == :national && @office_type == :house
      if @name
        # return Rep.joins(:office).where('division_id LIKE ?', '%cd:%').where('name LIKE ?', "%#{@name.capitalize}%")
        return Rep.joins(:office).where('division_id LIKE ?', '%cd:%').select
      end
      if @level == :national && @office_type == :house
        return Rep.joins(:office).where('division_id LIKE ?', '%cd:%')
      else


      end


    end
    # to add all house nationally
    # level will be national
    # no state will be passed
    # need to get reps from each state that have divsion_id %cd:%

    query = "ocd-division/country:us/state:#{@state}"




  end


end
