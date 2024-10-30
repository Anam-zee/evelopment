document.addEventListener("DOMContentLoaded", function() {
  var alertElement = document.querySelector('.alert');
  var noticeElement = document.querySelector('.notice');

  if (alertElement) {
    setTimeout(function() {
      alertElement.remove()
    }, 3000);
  }

  if (noticeElement) {
    setTimeout(function() {
      noticeElement.remove()
    }, 3000);
  }
})

function showEvent(button) {
  const id = button.dataset.id;

  fetch(`/events/${id}`)
    .then(response => response.text())
    .then(html => {
      document.getElementsByTagName('html')[0].innerHTML = html
      window.history.pushState({}, '', `/events/${id}`)
    })
    .catch(error => console.error('Error fetching event:', error))
}

const newEvent = () => {
  fetch('/events/new')
    .then(response => response.text())
    .then(html => {
      document.getElementsByTagName('html')[0].innerHTML = html
    })
    .catch(error => console.log(error));

  window.history.pushState({}, '', `/events/new`)

  setTimeout(() => {
    loadCreateCode()
  }, 300)
}

function loadCreateCode() {
  document.getElementById('create_form').addEventListener('submit', function(event) {
    createEvent(event, this)
  })
}

function loadUpdateCode() {
  document.getElementById('edit_form').addEventListener('submit', function(event) {
    updateEvent(event, this)
  })
}

function createEvent(event, pointer) {
  event.preventDefault()

  let formData = new FormData(pointer)

  fetch(pointer.action, {
    method: pointer.method,
    body: formData,
    headers: {
      'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
    }
  })
  .then(response => response.json())
  .then(data => {
    if (!data.errors) {
      fetchShowPage(data.path)
    } else {
      ['event_name', 'event_description', 'event_date', 'event_location'].forEach((input, index) => {
        if (document.getElementById(`${input}`).value.trim() == '') {
          document.getElementById(`${input}_field_error`).innerHTML = `${capitalizeFirstLetter(input.split('_')[1])} can't be blank`
        } else {
          document.getElementById(`${input}_field_error`).innerHTML = ''
        }
      })
    }
  })
  .catch(error => {})
}

const validateInput = (event) => {
  if (event.value.trim() != '') {
    document.getElementById(`${event.id}_field_error`).innerHTML = ''
  } else {
    document.getElementById(`${event.id}_field_error`).innerHTML = `${capitalizeFirstLetter(event.id.split('_')[1])} can't be blank`
  }
}

const capitalizeFirstLetter = string => string.charAt(0).toUpperCase() + string.slice(1)

function fetchShowPage(path) {
  fetch(path)
    .then(response => response.text())
    .then(html => {
      document.getElementsByTagName('html')[0].innerHTML = html
      window.history.pushState({}, '', path)
    })
    .catch(error => console.error('Error:', error))
}

const viewAllEvents = () => {
  fetch('/events')
    .then(response => response.text())
    .then(html => {
      document.getElementsByTagName('html')[0].innerHTML = html
    })
    .catch(error => console.log(error));

  window.history.pushState({}, '', `/events`)
}

function deleteEvent(button) {
  const eventId = button.dataset.id

  const confirmation = confirm('Are you sure you want to delete this event?')

  if (!confirmation) return

  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  fetch(`/events/${eventId}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
    })
    .then(response => {
      if (response.ok) {
        return response.json()
      }

      throw new Error(`HTTP error! Status: ${response.status}`)
    })
    .then(data => {
      viewAllEvents()
    })
    .catch(error => {
      console.error('Error deleting event:', error)
    })
  }

function handleLogoClick() {
  fetch('/')
    .then(response => response.text())
    .then(html => {
      document.getElementsByTagName('html')[0].innerHTML = html
    })
    .catch(error => console.log(error));

  window.history.pushState({}, '', `/`)
}

function editEvent(button) {
  const id = button.dataset.id
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  fetch(`/events/${id}/edit`)
    .then(response => response.text())
    .then(html => {
      document.getElementsByTagName('html')[0].innerHTML = html
    })
    .catch(error => console.error('Error fetching event:', error))

  window.history.pushState({}, '', `/events/${id}/edit`)

  setTimeout(() => {
    loadUpdateCode()
  }, 300)
}

function updateEvent(event, pointer) {
  event.preventDefault()

  let formData = new FormData(pointer)

  fetch(pointer.action, {
    method: pointer.method,
    body: formData,
    headers: {
      'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
    }
  })
  .then(response => response.json())
  .then(data => {
    if (!data.errors) {
      fetchShowPage(data.path)
    } else {
      ['event_name', 'event_description', 'event_date', 'event_location'].forEach((input, index) => {
        if (document.getElementById(`${input}`).value.trim() == '') {
          document.getElementById(`${input}_field_error`).innerHTML = `${capitalizeFirstLetter(input.split('_')[1])} can't be blank`
        } else {
          document.getElementById(`${input}_field_error`).innerHTML = ''
        }
      })
    }
  })
  .catch(error => {})
}

function joinEvent(button) {
  const id = button.dataset.id

  fetch(`/events/${id}/join`, {
    method: 'POST',
    headers: {
      'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
    }
  })
    .then(response => response.text())
    .then(html => {
      showEvent(button)
    })
    .catch(error => console.error('Error joining Event:', error))
}

function leaveEvent(button) {
  const id = button.dataset.id

  fetch(`/events/${id}/unjoin`, {
    method: 'POST',
    headers: {
      'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
    }
  })
    .then(response => response.text())
    .then(html => {
      debugger
      showEvent(button)
    })
    .catch(error => console.error('Error joining Event:', error))
}
