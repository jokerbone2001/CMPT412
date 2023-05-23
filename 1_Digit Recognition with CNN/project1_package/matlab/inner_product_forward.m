function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);

% Replace the following line with your implementation.
output.data = zeros([n, k]);
output.batch_size = k;
output.width = input.width;
output.height = input.height;
output.channel = input.channel;
for i = 1:k
    output.data(:,i) = input.data(:,i).' * param.w + param.b;
end
