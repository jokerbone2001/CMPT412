function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    batch_data.height=h_in;
    batch_data.width=w_in;
    batch_data.channel=c;
    for batch=1:batch_size
      batch_data.data=input.data(:,batch);
      image=im2col_conv(batch_data, layer, h_out, w_out);
      %select
      kkimage=reshape(image, k*k, c, h_out*w_out);
      max_kkimage = max(kkimage);
      max_data = reshape(max_kkimage,c,h_out*w_out);
      output.data(:,batch) = reshape(max_data', [], h_out*w_out*c);
    end
end

