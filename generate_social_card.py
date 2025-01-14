import base64
from io import BytesIO
from PIL import Image, ImageDraw, ImageFont

def create_social_card():
    width, height = 400, 200
    bg_color = (24, 24, 24)  # Dark gray
    text_color = (255, 255, 255)

    # Create a new image
    img = Image.new("RGB", (width, height), bg_color)
    draw = ImageDraw.Draw(img)

    # Text content
    title = "Datainc"
    subtitle = "Open-Source Alt Data Pipeline"

    # Attempt to load Arial; fallback if unavailable
    try:
        title_font = ImageFont.truetype("arial.ttf", 24)
        subtitle_font = ImageFont.truetype("arial.ttf", 16)
    except OSError:
        title_font = ImageFont.load_default()
        subtitle_font = ImageFont.load_default()

    def get_text_size(draw_ctx, text, font):
        """
        Attempts to get text width & height in a way that works
        across multiple Pillow versions.
        """
        # 1. Prefer textbbox() if available (Pillow ≥ 8.0.0)
        if hasattr(draw_ctx, "textbbox"):
            left, top, right, bottom = draw_ctx.textbbox((0, 0), text, font=font)
            return (right - left, bottom - top)

        # 2. Fallback to textsize() if the draw_ctx still supports it
        elif hasattr(draw_ctx, "textsize"):
            return draw_ctx.textsize(text, font=font)

        # 3. Last resort: return (0,0) or implement more exotic methods
        return (0, 0)

    # Calculate text sizes
    title_w, title_h = get_text_size(draw, title, title_font)
    subtitle_w, subtitle_h = get_text_size(draw, subtitle, subtitle_font)

    # Center the text vertically
    spacing = 10
    total_height = title_h + subtitle_h + spacing
    start_y = (height - total_height) // 2

    # Draw the title
    title_x = (width - title_w) // 2
    draw.text((title_x, start_y), title, fill=text_color, font=title_font)

    # Draw the subtitle
    subtitle_x = (width - subtitle_w) // 2
    draw.text((subtitle_x, start_y + title_h + spacing), subtitle, fill=text_color, font=subtitle_font)

    return img

if __name__ == "__main__":
    image = create_social_card()

    # Save as PNG
    image.save("social_card.png")
    print("Saved social_card.png")

    # Print base64 to console (optional)
    buffered = BytesIO()
    image.save(buffered, format="PNG")
    b64_img = base64.b64encode(buffered.getvalue()).decode("utf-8")
    print("\nBase64-encoded PNG:\n")
    print(b64_img)