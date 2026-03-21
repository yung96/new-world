import openrouteservice

coords = ((8.34234, 48.23424), (8.34423, 48.26424))

client = openrouteservice.Client(
    key="eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6ImYxYmMyNzQ1N2RhZjQ4ZWQ4NTJkMDY1YjkxYmJiZDQzIiwiaCI6Im11cm11cjY0In0="
)
routes = client.directions(coords)

print(routes)
