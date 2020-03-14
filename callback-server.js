let express = require('express');
let app = express();
let port = 8000

app.get('/:callback', function (req, res) {
  
  console.log(req.query)
  console.log(req.params)
  
  res.send({
    'msg': 'Using this code to exchange access token 👇',
    ...req.query
  })
});

app.listen(8000, function () {
  console.log(`Local callback server listening on port ${port}!`);
});

