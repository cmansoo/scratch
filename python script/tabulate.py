import tabulate

table = [['First Name', 'Last Name', 'Age'], ['John', 'Smith', 39], ['Mary', 'Jane', 25], ['Jennifer', 'Doe', 28]]

print(tabulate.tabulate(table))
print(tabulate.tabulate(table, headers='firstrow'))
print(tabulate.tabulate(table, headers='firstrow', tablefmt='grid'))
