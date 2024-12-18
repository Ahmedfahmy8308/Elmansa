const materials = []; // Array to store materials

// Dynamic input handling for material type
document.getElementById('materialType').addEventListener('change', function () {
    const fileInput = document.getElementById('materialFile');
    const linkInput = document.getElementById('materialLink');
    fileInput.classList.add('d-none');
    linkInput.classList.add('d-none');

    if (this.value === 'video' || this.value === 'pdf') {
        fileInput.classList.remove('d-none');
        fileInput.accept = this.value === 'pdf' ? '.pdf' : '.mp4';
    } else if (this.value === 'link') {
        linkInput.classList.remove('d-none');
    }
});

// Add Material to the list
function addMaterial() {
    const title = document.getElementById('materialTitle').value;
    const type = document.getElementById('materialType').value;
    const fileInput = document.getElementById('materialFile');
    const linkInput = document.getElementById('materialLink');

    if (!title || !type) {
        alert('Please fill in all fields.');
        return;
    }

    let material = { title, type };

    if (type === 'video' || type === 'pdf') {
        if (fileInput.files.length === 0) {
            alert('Please upload a file.');
            return;
        }
        material.fileName = fileInput.files[0].name;
    } else if (type === 'link') {
        if (!linkInput.value) {
            alert('Please provide a link.');
            return;
        }
        material.link = linkInput.value;
    }

    materials.push(material);
    displayMaterials();
    clearInputs();
}

// Display Materials
function displayMaterials() {
    const materialsList = document.getElementById('materialsList');
    materialsList.innerHTML = '';

    materials.forEach((material, index) => {
        const materialHTML = `
                    <div class="material-container d-flex justify-content-between align-items-center">
                        <div>
                            <strong>${material.title}</strong> - ${material.type.toUpperCase()}
                            ${material.fileName ? `<div class="text-muted">${material.fileName}</div>` : ''}
                            ${material.link ? `<div class="text-muted">${material.link}</div>` : ''}
                        </div>
                        <button class="btn btn-danger btn-sm" onclick="deleteMaterial(${index})">
                            <i class="bi bi-trash"></i>
                        </button>
                    </div>
                `;
        materialsList.insertAdjacentHTML('beforeend', materialHTML);
    });
}

// Delete Material
function deleteMaterial(index) {
    materials.splice(index, 1);
    displayMaterials();
}

// Publish Materials
function publishMaterials() {
    if (materials.length === 0) {
        alert('Please add at least one material before publishing.');
        return;
    }

    console.log('Materials Published:', materials); // This is where you send data to server
    const successAlert = document.getElementById('successAlert');
    successAlert.classList.remove('d-none');

    setTimeout(() => {
        successAlert.classList.add('d-none');
    }, 3000);

    clearForm();
}

// Clear Form Inputs
function clearInputs() {
    document.getElementById('materialTitle').value = '';
    document.getElementById('materialFile').value = '';
    document.getElementById('materialLink').value = '';
    document.getElementById('materialType').value = '';
    document.getElementById('materialFile').classList.add('d-none');
    document.getElementById('materialLink').classList.add('d-none');
}

// Clear All Form and Material List
function clearForm() {
    clearInputs();
    materials.length = 0;
    displayMaterials();
}