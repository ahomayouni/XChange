class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    if @notifications.length > 0
      @handleSuccess @notifications.data("notifications")
      $("[data-behavior='notifications-link']").on "click", @handleClick
      setInterval (=>
        @getNewNotifications()
      ), 1000
      

  getNewNotifications: ->
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleClick: (e) =>
    $.ajax(
      url: "/notifications/mark_as_read"
      dataType: "JSON"
      method: "POST"
      remote: true
      success: ->
        console.log("Success")
    )

  handleSuccess: (data) =>
    items = $.map data, (notification) ->
      notification.template

    unread_count = 0
    $.each data, (i, notification) ->
      console.log(notification.read_at)
      if notification.unread
        unread_count += 1

    $("[data-behavior='unread-count']").text(unread_count)
    $("[data-behavior='notification-items']").html(items.join("<br />"))

jQuery ->
  new Notifications
