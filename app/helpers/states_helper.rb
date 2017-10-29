module StatesHelper
  include ApplicationHelper
  def states
    states = []
      state  = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)
      state.each do |state|
        states << Array[state]
      end
      states
  end
end
