const std = @import("std");

const bytecodeMappings = [_]u8{ '+', '-', '>', '<', '[', ']', '.', ',', '_', '\'', '`', '%', ';' };

pub fn main() !void {
    const args = std.os.argv;
    if (args.len < 2) {
        std.debug.print("expected 'raidump <file>'\n", .{});
        return;
    }

    const allocator = std.heap.page_allocator;

    var fpath = std.ArrayList(u8).init(allocator);
    var i: usize = 0;
    while (args[1][i] != 0) {
        try fpath.append(args[1][i]);
        i += 1;
    }

    const max_size = std.math.maxInt(usize);

    const data = try std.fs.cwd().readFileAlloc(allocator, fpath.items, max_size);
    defer allocator.free(data);

    var commands = try allocator.alloc(u8, data.len);
    defer allocator.free(commands);

    for (data, 0..) |c, ind| {
        //std.debug.print("{d}: {d} -> '{c}'\n", .{ ind, c, bytecodeMappings[ind] });
        commands[ind] = bytecodeMappings[c];
    }

    std.debug.print("{s}\n", .{commands});
}
