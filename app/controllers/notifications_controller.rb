class NotificationsController < ApplicationController
  include Response
  before_action :notification_params, only: :create
  AUTHORS = {
    namtx: "[To:2261556]",
    phandinhman: "[To:1956097]",
    leductienttkt: "[To:2155577]",
    tjn0994: "[To:2031014]",
    khacthe: "[To:2259103]",
    NguyenHuuGiap: "[To:2031044]",
    phantien133: "[To:2076238]",
    "chau-bao-long": "[To:1946161]"
  }
  def create
    ChatWork.api_key = ENV["CHATWORK_API_TOKEN"]
    body = @body[:body]
    author_name = body[/Author:\s(.+)\n/, 1].to_sym
    converted_body = body
    converted_body = body.gsub(author_name.to_s, AUTHORS[author_name]) if AUTHORS.keys.include?(author_name)
    ChatWork::Message.create room_id: ENV["CHATWORK_ROOM"], body: converted_body
  end

  private
  def notification_params
    @body = params.require :webhook_event
  end
end
