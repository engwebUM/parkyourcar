FactoryGirl.define do
  states = [BookingsController::SENT_STATE,
            BookingsController::PENDING_STATE,
            BookingsController::ACCEPTED_STATE,
            BookingsController::REJECTED_STATE]

  factory :booking do
    date_from   { DateTime.current + 1.week }
    date_until  { DateTime.current + 2.weeks }
    state       { states.sample }

    factory :booking_sent do
      state     { BookingsController::SENT_STATE }
    end
  end
end
