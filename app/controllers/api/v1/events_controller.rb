module Api
  module V1
    class EventsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_event, only: %i[ show edit update destroy join unjoin ]
      after_action :return_event, only: %i[ new edit join unjoin ]

      def index
        @events = Event.all

        respond_to do |format|
          format.html
          format.json { render json: @events }
        end
      end

      def new
        @event = current_user.organized_events.new
      end

      def create
        @event = current_user.organized_events.new(event_params)

        if @event.save
          @event.joiners << current_user

          render json: { path: "/events/#{@event.id}" }, status: :created
        else
          render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @event.update(event_params)
          render json: { path: "/events/#{@event.id}" }, status: :accepted
        else
          render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @event.destroy

        render json: { success: true, message: 'Event Deleted Successfully!' }
      end

      def join
        @event.joiners << current_user
      end

      def unjoin
        @event.joiners.delete(current_user)
      end

      private

        def set_event
          @event = Event.find_by(id: params[:id])
        end

        def event_params
          params.require(:event).permit(:name, :description, :date, :location, :organizer)
        end

        def return_event
          respond_to do |format|
            format.html
            format.json { render json: @event }
          end
        end
    end
  end
end
