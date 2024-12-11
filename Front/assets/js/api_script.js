// Get the two div elements
const div1 = document.getElementById('signin_Content');
const div2 = document.getElementById('signup_Content');

// Add click event listeners to both divs
div1.addEventListener('click', () => {
    callLoginApi('signin_Content');
});

div2.addEventListener('click', () => {
    handleFormSubmission('signup_Content');
});


/*    *************************************************************************      */


function handleFormSubmission(formid) {
    // Define the function that handles the form submission
    document.getElementById("registerform").addEventListener("submit", async function (event) {
        event.preventDefault(); // Prevent the default form submission

        // Collect form data
        const formData = new FormData(event.target);

        // Convert FormData to a plain object for easier manipulation
        const data = Object.fromEntries(formData.entries());


        try {
            // Make the POST request to the API
            const response = await fetch("http://localhost:5228/api/Account/Register", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(data)
            });

            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.message || "Unknown error occurred.");
            }

            alert("Registration successful!");
            event.target.reset(); // Reset the form after successful registration

        } catch (error) {
            console.error("Error during registration:", error);
            alert("Error during registration: " + error.message);
        }
    });
}









// Function to call the API
/* try {
    fetch('http://localhost:5228/api/Account/Register', {
        method: 'POST', // Specify the HTTP method
        body: new FormData(document.querySelector('form')) // Collect form data
    })
        .then(response => response()) // Read response as text
        .then(data => alert(data)); // Alert the response
} catch (error) {
    alert('An error occurred!');
}

/* function callRegisterApi(activeDivId) {
    const form = document.getElementById('registerform');

    // Add submit event listener
    form.addEventListener('submit', async (event) => {

        // Collect input values
        const formData = new FormData();
        var email = document.getElementById('email2');
        var password = document.getElementById('password2');
        var firstname = document.getElementById('fname');
        var middlename = document.getElementById('mname');
        var lastname = document.getElementById('lname');
        var phone = document.getElementById('phone');
        var ssn = document.getElementById('ssn');
        var dateofbirth = document.getElementById('date_of_birth');
        var photo = document.getElementById('fileInput').files[0]; // File input
        var graduentvar = document.getElementById('phone2');

        try {
            console.log('API Response');
            const response = await fetch('http://localhost:5228/api/Account/Register', {
                method: 'POST',
                body: JSON.stringify({
                    Student_email: email,
                    Student_password: password,
                    Student_first_name: firstname,
                    Student_Middel_name: middlename,
                    Student_last_name: lastname,
                    Student_number: phone,
                    Student_SSN: ssn,
                    Student_date_birth: dateofbirth,
                    Student_photo: photo,
                    Student_guardian_number: graduentvar

                })
            }).then(function (response) {
                return response.json()
            }
            )
                .then(function (data) {
                    console.log(data)
                })


            // Check if the response status is not OK (200-299)
            if (!response.ok) {
                // Log the status and statusText for debugging
                console.error(`Error: ${response.status} ${response.statusText}`);
                const errorResponse = await response.json();
                throw new Error(errorResponse.message || 'Something went wrong'); // Display server-side error
            }
            if (response.status === 204) {  // Status 204 means no content
                console.log('No content returned.');
                return null; // Return null if no content
            }

            return response.json(); // Parse as JSON if response is not empty
            // Parse response if successful
            const data = await response.json();
            console.log('API Response:', data);
            alert('Registration successful!'); // Notify user
        }
        catch (error) {
            // Handle fetch or JSON parsing errors
            console.error('Error occurred:', error.message);

            // Show a user-friendly message
            alert(`Error: ${error.message || 'Unable to complete the request.'}`);
            return;
        }
    });
}
} */
