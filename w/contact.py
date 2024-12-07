numbers = [
    "1070284088", "1557529282", "1101094447", "1029090006",
    "1029562992", "1068796007", "1281427908"
]

names = [
    "Ahmed elsaied essa", "Alaa elezaby", "Laila ehab", "Yasmein karam",
    "Mena Mohamed", "Menna allah rafat sobh", "Ahmed nabil"
]

# Add "IEEE .NET" to each name
names = [name + " IEEE .pr" for name in names]

# Ensure the lists have the same length
if len(numbers) != len(names):
    print("Error: The 'numbers' and 'names' lists should have the same length.")
else:
    # Create and write to a vCard file
    with open('contacts_pr2.vcf', mode='w') as file:
        for name, number in zip(names, numbers):
            vcard = f"BEGIN:VCARD\nVERSION:3.0\nN:{name}\nFN:{name}\nTEL;TYPE=CELL:{number}\nEND:VCARD\n"
            file.write(vcard)
    print("contacts.vcf file created successfully.")
