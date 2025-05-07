$(document).ready(function () {
    const FORM_SELECTOR = '#guestForm';
    const MESSAGES_CONTAINER = '#messages';
    const PAGINATION_CONTAINER = '#pagination';
    const EDIT_MODAL = '#editModal';
    const EDIT_FORM = '#editForm';
    const EDIT_SUBMIT_BUTTON = '#editSubmit';
    const EDIT_CANCEL_BUTTON = '#editCancel';
    const AJAX_URL = 'ajax.php';

    let modalHideReason = null;

    loadMessages(1);
    setupFormSubmit();
    setupPagination();
    setupEditForm();

    // VALIDATION FOR MAIN FORM -----------------------------------------------------------------------------------------------------------

    function validateForm() {
        let isValid = true;
        $('#nameError, #emailError, #messageError').text('');

        const name = $('#name').val();
        if (name.length < 5 || name.length > 128) {
            $('#nameError').text('Name must be between 5 and 128 characters.');
            isValid = false;
        }

        const email = $('#email').val();
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(email)) {
            $('#emailError').text('Please enter a valid email address.');
            isValid = false;
        }

        const message = $('#message').val();
        if (message.length < 5 || message.length > 1024) {
            $('#messageError').text('Message must be between 5 and 1024 characters.');
            isValid = false;
        }

        return isValid;
    }

    // VALIDATION FOR EDIT FORM -----------------------------------------------------------------------------------------------------------

    function validateEditForm() {
        let isValid = true;
        $('#edit_nameError, #edit_emailError, #edit_messageError').text('');

        const name = $('#edit_name').val();
        if (name.length < 5 || name.length > 128) {
            $('#edit_nameError').text('Name must be between 5 and 128 characters.');
            isValid = false;
        }

        const email = $('#edit_email').val();
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(email)) {
            $('#edit_emailError').text('Please enter a valid email address.');
            isValid = false;
        }

        const message = $('#edit_message').val();
        if (message.length < 5 || message.length > 1024) {
            $('#edit_messageError').text('Message must be between 5 and 1024 characters.');
            isValid = false;
        }

        return isValid;
    }

    // AJAX SUBMIT FOR MAIN FORM -----------------------------------------------------------------------------------------------------------

    function setupFormSubmit() {
        $(FORM_SELECTOR).on('submit', function (e) {
            e.preventDefault();
            if (!validateForm()) return;

            const formData = {
                action: 'submit',
                name: $('#name').val(),
                email: $('#email').val(),
                message: $('#message').val()
            };

            $.ajax({
                type: 'POST',
                url: AJAX_URL,
                data: formData,
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        loadMessages(1);
                        $(FORM_SELECTOR)[0].reset();
                    } else {
                        alert('Error: ' . response.error);
                    }
                },
                error: function () {
                    alert('An error occurred.');
                }
            });
        });
    }

    // AJAX LOAD MESSAGES -----------------------------------------------------------------------------------------------------------

    function loadMessages(page) {
        $.ajax({
            type: 'POST',
            url: AJAX_URL,
            data: { action: 'get_messages', page: page },
            dataType: 'json',
            success: function (response) {
                if (response.success) {
                    renderMessages(response.messages);
                    setupEditButtonTimers(response.messages);
                    renderPagination(response.total, response.limit, page);
                }
            }
        });
    }

    // RENDER MESSAGES -----------------------------------------------------------------------------------------------------------

    function renderMessages(messages) {
        let html = '';
        messages.forEach(function (msg) {
            html += `
                <div class="panel panel-default" data-id="${msg.id}">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <p>${msg.name}</p>
                            <p><small><time>${msg.time || 'N/A'} UTC</time></small></p>
                        </h3>
                    </div>
                    <div class="panel-body">
                        <p>${msg.message}</p>
                        <p><small class="email">${msg.email}</small></p>
                        ${msg.editable ? `
                            <button class="btn btn-default btn-sm edit-btn" 
                                    data-id="${msg.id}" 
                                    data-remaining="${msg.remaining_time}" 
                                    data-name="${msg.name}" 
                                    data-email="${msg.email}" 
                                    data-message="${msg.message}">
                                Edit (${msg.remaining_time}s)
                            </button>
                        ` : ''}
                    </div>
                </div>
            `;
        });
        $(MESSAGES_CONTAINER).html(html);
    }

    // EDIT BUTTON TIMER -----------------------------------------------------------------------------------------------------------

    function setupEditButtonTimers(messages) {
        $('.edit-btn').each(function () {
            const $btn = $(this);
            let remaining = parseInt($btn.data('remaining'));

            if (remaining > 0) {
                const interval = setInterval(function () {
                    remaining--;
                    if (remaining <= 0) {
                        clearInterval(interval);
                        $btn.remove();
                    } else {
                        $btn.text(`Edit (${remaining}s)`);
                        $btn.data('remaining', remaining);
                    }
                }, 1000);
                $btn.data('interval', interval);
            } else {
                $btn.remove();
            }
        });
    }

    // RENDER PAGINATION -----------------------------------------------------------------------------------------------------------

    function renderPagination(total, limit, currentPage) {
        const totalPages = Math.ceil(total / limit);
        let paginationHtml = '';

        const maxVisiblePages = 5;
        let startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
        let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);

        if (endPage - startPage + 1 < maxVisiblePages && startPage > 1) {
            startPage = Math.max(1, endPage - maxVisiblePages + 1);
        }

        if (currentPage > 1) {
            paginationHtml += `<button class="btn btn-default page-btn" data-page="${currentPage - 1}">Previous</button>`;
        }

        for (let i = startPage; i <= endPage; i++) {
            paginationHtml += `
                <button class="btn btn-default page-btn${i === currentPage ? ' active' : ''}" 
                        data-page="${i}">${i}</button>
            `;
        }

        if (currentPage < totalPages) {
            paginationHtml += `<button class="btn btn-default page-btn" data-page="${currentPage + 1}">Next</button>`;
        }

        $(PAGINATION_CONTAINER).html(paginationHtml);
    }

    // PAGINATION HANDLER -----------------------------------------------------------------------------------------------------------

    function setupPagination() {
        $(document).on('click', '.page-btn', function () {
            loadMessages($(this).data('page'));
        });
    }

    // EDIT MODAL FORM -----------------------------------------------------------------------------------------------------------

    function setupEditForm() {
        $(document).on('click', '.edit-btn', function () {
            const $btn = $(this);
            const messageId = $btn.data('id');
            clearInterval($btn.data('interval'));

            $('#edit_message_id').val(messageId);
            $('#edit_name').val($btn.data('name'));
            $('#edit_email').val($btn.data('email'));
            $('#edit_message').val($btn.data('message'));
            $('#edit_nameError, #edit_emailError, #edit_messageError').text('');
            $(EDIT_MODAL).modal('show');

            const originalData = getEditFormData();
            $(EDIT_SUBMIT_BUTTON).prop('disabled', true);
            $('#editForm input, #editForm textarea').on('input', function () {
                const currentData = getEditFormData();
                $(EDIT_SUBMIT_BUTTON).prop('disabled', JSON.stringify(currentData) === JSON.stringify(originalData));
            });
        });

        $(EDIT_FORM).on('submit', function (e) {
            e.preventDefault();
            if (!validateEditForm()) return;

            const formData = {
                action: 'edit',
                message_id: $('#edit_message_id').val(),
                name: $('#edit_name').val(),
                email: $('#edit_email').val(),
                message: $('#edit_message').val()
            };

            $.ajax({
                type: 'POST',
                url: AJAX_URL,
                data: formData,
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        modalHideReason = 'submit';
                        $(EDIT_MODAL).modal('hide');
                        loadMessages(1);
                    } else {
                        alert('Error: ' + response.error);
                    }
                }
            });
        });

        $(EDIT_CANCEL_BUTTON).on('click', function () {
            modalHideReason = 'cancel';
            handleModalClose($('#edit_message_id').val());
            $(EDIT_MODAL).modal('hide');
        });

        $(EDIT_MODAL).on('hidden.bs.modal', function () {
            if (modalHideReason === null) {
                handleModalClose($('#edit_message_id').val());
            }
            modalHideReason = null;
        });
    }

    function getEditFormData() {
        return {
            name: $('#edit_name').val(),
            email: $('#edit_email').val(),
            message: $('#edit_message').val()
        };
    }

    // MODAL CLOSE -----------------------------------------------------------------------------------------------------------

    function handleModalClose(messageId) {
        const $btn = $(`.edit-btn[data-id="${messageId}"]`);
        if (!$btn.length) return;

        $.ajax({
            type: 'POST',
            url: AJAX_URL,
            data: { action: 'get_messages', page: 1 },
            dataType: 'json',
            success: function (response) {
                if (response.success) {
                    const message = response.messages.find(msg => msg.id == messageId);
                    if (message && message.editable) {
                        let remaining = message.remaining_time;
                        $btn.data('remaining', remaining);
                        $btn.text(`Edit (${remaining}s)`);

                        if (remaining > 0) {
                            const interval = setInterval(function () {
                                remaining--;
                                if (remaining <= 0) {
                                    clearInterval(interval);
                                    $btn.remove();
                                } else {
                                    $btn.text(`Edit (${remaining}s)`);
                                    $btn.data('remaining', remaining);
                                }
                            }, 1000);
                            $btn.data('interval', interval);
                        } else {
                            $btn.remove();
                        }
                    } else {
                        $btn.remove();
                    }
                }
            },
            error: function () {
                $btn.remove();
            }
        });
    }
});