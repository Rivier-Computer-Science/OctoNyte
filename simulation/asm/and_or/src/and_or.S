.section .text
.global and_operation
.global or_operation

# AND operation: result = x & y
and_operation:
    and a0, a0, a1  # Perform bitwise AND
    ret             # Return result in a0

# OR operation: result = x | y
or_operation:
    or a0, a0, a1   # Perform bitwise OR
    ret             # Return result in a0
