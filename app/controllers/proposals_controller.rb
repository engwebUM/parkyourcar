class ProposalsController < BookingsController
  def aprove
    change_state(PENDING_STATE)
  end

  def reject
    change_state(REJECTED_STATE)
  end

  def accept
    change_state(ACCEPTED_STATE)
  end

  private

  def bookings_by_state(state)
    param_state_page = state + '_page'
    Booking.where(space: current_user.spaces, state: state).order(:space_id).paginate(page: params[param_state_page], per_page: 2)
  end

  def change_state(state)
    @booking = Booking.find(params[:id])
    @booking.update(state: state) if current_user == @booking.space.user && conditions_are_met(state)
    redirect_to action: :index
  end

  def conditions_are_met(state)
    case @booking.state
    when SENT_STATE
      state == PENDING_STATE || state == REJECTED_STATE
    when PENDING_STATE
      state == ACCEPTED_STATE || state == REJECTED_STATE
    else
      false
    end
  end
end
