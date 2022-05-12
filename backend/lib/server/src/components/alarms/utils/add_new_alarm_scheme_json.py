base_start_and_end_time = {
    "type": "object",
    "properties": {
        "hour": {"type": "number"},
        "minute": {"type": "number"}
    },
    "required": ["hour","minute"]
}

alarm_schema_json = {
    'type': 'object',
    'properties': {
        'time': {
            'type': 'object',
            'properties': {
                "start_alarm": base_start_and_end_time,
                "end_alarm": base_start_and_end_time
            },
            'required': ['start_alarm',"end_alarm"]
        },
        "objects": {"type": "array"},
        "alarm_days": {"type": "array"},
        "status": {"type": "boolean","default": True},
    },
    'required': ['time', 'objects',"alarm_days"]
}