class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  before_action :set_event, only: %i[show]
  before_action :set_current_user_event, only: %i[edit update destroy]

  def index
    @events = Event.all
  end

  def show
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
  end

  def new
    @event = current_user.events.build
  end

  def edit; end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      format.html { redirect_to event_url(@event), notice: I18n.t('controllers.events.created') }
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  def update
    if @event.update(event_params)
      format.html { redirect_to event_url(@event), notice: I18n.t('controllers.events.updated') }
    else
      format.html { render :edit, status: :unprocessable_entity }
    end
  end

  def destroy
    @event.destroy

    format.html { redirect_to events_url, notice: I18n.t('controllers.events.destroyed') }
  end

  private

  def set_current_user_event
    @event = current_user.events.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description)
  end
end
