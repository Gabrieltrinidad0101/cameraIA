import functools
from flask import request,jsonify
import server.src.services.database.token as DatabaseToken
def token_requires(fun):
    @functools.wraps(fun)
    def wrapped_view(**kwargs):
        token = request.headers.get('token')
        if not token:
            return jsonify({'error': "you don't have token"}),500
        token_is_not_correct = DatabaseToken.verify_token(token)
        if token_is_not_correct: return jsonify({'error': "the token is incorrent"}),500
        return fun(**kwargs)
    return wrapped_view