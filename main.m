#import <Foundation/Foundation.h>

int main(int argc, char * argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: pl [path]\n");
        return -1;
    }

    @autoreleasepool {
        NSString *path = [NSString stringWithUTF8String:argv[1]];
        NSDictionary *content = [NSDictionary dictionaryWithContentsOfFile:path];
        puts(content.description.UTF8String);
    }
    return 0;
}