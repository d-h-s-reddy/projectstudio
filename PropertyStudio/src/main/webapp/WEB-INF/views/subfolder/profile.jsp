<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.pennant.propertystudio.models.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Profile</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card-title {
            font-size: 1.5rem;
            color: #007bff;
        }
        .list-group-item {
            border: none;
            padding: 0.75rem 1.25rem;
            display: flex;
            align-items: center;
        }
        .list-group-item strong {
            flex: 1;
        }
        .list-group-item span, .list-group-item input {
            flex: 2;
        }
        .list-group-item input {
            display: none;
        }
        .list-group-item.editable input {
            display: inline-block;
        }
        .list-group-item.editable span {
            display: none;
        }
        .btn-edit {
            flex: 0.5;
            margin-left: 10px;
        }
        .btn-save {
            flex: 0.5;
            display: none;
            margin-left: 10px;
        }
        .editable .btn-edit {
            display: none;
        }
        .editable .btn-save {
            display: inline-block;
        }
        .margin {
            width: 200px; /* Adjust the width as needed */
            display: inline-block;
            margin-right: 542px; /* Adjust the right margin as needed */
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function enableEditing(fieldId) {
            var fieldName = $("#" + fieldId).find('strong').text();
            var confirmation = confirm("Do you want to edit your " + fieldName + "?");
            if (confirmation) {
                var field = $("#" + fieldId);
                field.addClass('editable');
                field.find('input').focus();
            }
        }

        function saveField(fieldId) {
            var field = $("#" + fieldId);
            var input = field.find('input');
            var span = field.find('span');
            var newValue = input.val();

            console.log("Field ID: " + fieldId);
            console.log("New Value: " + newValue);

            // Make AJAX POST request to update the field
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/update",
                data: { fieldId: fieldId, value: newValue },
                success: function(response) {
                    
                    console.log("Response: " + response);
                    span.text(newValue);
                    // Remove the editable class
                    field.removeClass('editable');
                },
                error: function(xhr, status, error) {
                    // Handle error if any
                    console.error("Error: " + error);
                }
            });
        }
    </script>
</head>
<body>
<div class="container">
    <h2 class="mb-4">Customer Profile</h2>
    <div class="card">
        <div class="card-body">
            <% 
                Customer customer = (Customer)request.getAttribute("customer");
                
            %>
            <h5 class="card-title"><%= customer.getFirstname() + " " + customer.getLastname() %></h5>
            <ul class="list-group list-group-flush">
                <li class="list-group-item"><strong>Customer ID:</strong><div class="margin"><%= customer.getId() %></div></li>
                <li class="list-group-item"><strong>Email:</strong><i class="fas fa-envelope"></i><div class="margin"><%= customer.getEmail() %></div></li>
                <li class="list-group-item" id="firstNameField">
                    <strong>First Name:</strong>
                    <span><%= customer.getFirstname() %></span>
                    <input type="text" value="<%= customer.getFirstname() %>">
                    <!-- <button class="btn btn-sm btn-primary btn-edit" onclick="enableEditing('firstNameField')">Edit</button>
                    <button class="btn btn-sm btn-success btn-save" onclick="saveField('firstNameField')">Save</button>-->
                </li>
                <li class="list-group-item" id="lastNameField">
                    <strong>Last Name:</strong>
                    <span><%= customer.getLastname() %></span>
                    <input type="text" value="<%= customer.getLastname() %>">
                   <!--   <button class="btn btn-sm btn-primary btn-edit" onclick="enableEditing('lastNameField')">Edit</button>
                    <button class="btn btn-sm btn-success btn-save" onclick="saveField('lastNameField')">Save</button>-->
                </li>
                <li class="list-group-item" id="mobileField">
                    <strong>Mobile:</strong>
                    <i class="fas fa-phone"></i>
                    <span><%= customer.getMobile() %></span>
                    <input type="text" value="<%= customer.getMobile() %>">
                    <button class="btn btn-sm btn-primary btn-edit" onclick="enableEditing('mobileField')">Edit</button>
                    <button class="btn btn-sm btn-success btn-save" onclick="saveField('mobileField')">Save</button>
                </li>
                <li class="list-group-item" id="addressField">
                    <strong>Address:</strong>
                    <i class="fas fa-map-marker-alt"></i>
                    <span><%= customer.getAddress() %></span>
                    <input type="text" value="<%= customer.getAddress() %>">
                    <button class="btn btn-sm btn-primary btn-edit" onclick="enableEditing('addressField')">Edit</button>
                    <button class="btn btn-sm btn-success btn-save" onclick="saveField('addressField')">Save</button>
                </li>
                <li class="list-group-item" id="locationField">
                    <strong>Location:</strong>
                    <span><%= customer.getLocation() %></span>
                    <input type="text" value="<%= customer.getLocation() %>">
                    <button class="btn btn-sm btn-primary btn-edit" onclick="enableEditing('locationField')">Edit</button>
                    <button class="btn btn-sm btn-success btn-save" onclick="saveField('locationField')">Save</button>
                </li>
                <li class="list-group-item" id="pincodeField">
                    <strong>Pincode:</strong>
                    <span><%= customer.getPin() %></span>
                    <input type="text" value="<%= customer.getPin() %>">
                    <button class="btn btn-sm btn-primary btn-edit" onclick="enableEditing('pincodeField')">Edit</button>
                    <button class="btn btn-sm btn-success btn-save" onclick="saveField('pincodeField')">Save</button>
                </li>
                <li class="list-group-item" id="cityField">
                    <strong>City:</strong>
                    <span><%= customer.getCity() %></span>
                    <input type="text" value="<%= customer.getCity() %>">
                    <button class="btn btn-sm btn-primary btn-edit" onclick="enableEditing('cityField')">Edit</button>
                    <button class="btn btn-sm btn-success btn-save" onclick="saveField('cityField')">Save</button>
                </li>
            </ul>
            
        </div>
    </div>
</div>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>